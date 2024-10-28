package com.volunteer.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.volunteer.entity.Organizer;
import com.volunteer.service.OrganizerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;


@RestController
public class OrganizerController {

    @Autowired
    OrganizerService service;

    /**
     * 志愿发起者
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/OrganizerList")
    public ModelAndView OrganizerList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        Organizer Organizer = (Organizer)request.getSession().getAttribute("organizer");
        String key = request.getParameter("key");
        String status = request.getParameter("status");
        List<Organizer> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        maps.put("status", status);
        maps.put("oid", Organizer!=null?Organizer.getId():null);
        PageHelper.startPage(currentPage,8);
        list=service.selectOrganizerList(maps);
        PageInfo<Organizer> pageInfo=new PageInfo<Organizer>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/organizer/list");
    }

    @RequestMapping("/toAddOrganizer")
    public ModelAndView toAddOrganizer(HttpServletRequest request, ModelAndView mv){
        mv.setViewName("views/organizer/add");
        return mv;
    }

    @RequestMapping("/addOrganizer")
    @ResponseBody
    public boolean addOrganizer(Organizer Organizer){
        Organizer.setRegiste_time(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        boolean re = false;
        Organizer Organizer2 = service.selectOrganizerByOrganizerName(Organizer);
        if(Organizer2 ==null){
            service.addOrganizer(Organizer);
            re = true;
        }
        return re;
    }

    @RequestMapping("/deleteOrganizer")
    public boolean deleteOrganizer(HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        String id = request.getParameter("id");
        service.deleteOrganizer(Integer.parseInt(id));
        re = true;
        return re;
    }

    @RequestMapping("/toUpdateOrganizer")
    public ModelAndView toUpdateOrganizer(HttpServletRequest request, ModelAndView mv){
        String id=request.getParameter("id");
        Organizer Organizer = service.selectOrganizerById(Integer.parseInt(id));
        mv.addObject("Organizer", Organizer);
        mv.setViewName("views/organizer/update");
        return mv;
    }


    @RequestMapping("/updateOrganizer")
    @ResponseBody
    public boolean updateOrganizer(Organizer Organizer){
        boolean re = false;
        service.updateOrganizer(Organizer);
        re = true;
        return re;
    }
    @RequestMapping("/updateOrganizerState")
    @ResponseBody
    public boolean updateOrganizerState(Organizer Organizer){
        boolean re = false;
        service.updateOrganizerState(Organizer);
        re = true;
        return re;
    }
}

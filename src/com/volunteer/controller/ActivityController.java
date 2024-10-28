package com.volunteer.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.volunteer.entity.*;
import com.volunteer.service.ActivityService;
import com.volunteer.service.CategoryService;
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
public class ActivityController {

    @Autowired
    ActivityService service;

    @Autowired
    CategoryService categoryService;

    @RequestMapping("/ActivityList")
    public ModelAndView ActivityList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        Organizer Organizer = (Organizer)request.getSession().getAttribute("organizer");

        String key = request.getParameter("key");
        List<Activity> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        maps.put("oid", Organizer!=null?Organizer.getId():null);

        PageHelper.startPage(currentPage,8);
        list=service.selectActivityList2(maps);
        PageInfo<Activity> pageInfo=new PageInfo<Activity>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/activity/list");
    }

  /*  @RequestMapping("/ActivityList")
    public ModelAndView ActivityList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        List<Activity> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        PageHelper.startPage(currentPage,8);
        list=service.selectActivityList2(maps);
        PageInfo<Activity> pageInfo=new PageInfo<Activity>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/activity/list");
    }
*/

    @RequestMapping("/toAddActivity")
    public ModelAndView toAddActivity(HttpServletRequest request, ModelAndView mv){
        Map map = new HashMap<String,Object>();
        List<Category> categoryList = categoryService.selectCategoryList(map);
        mv.addObject("categoryList", categoryList);
        mv.setViewName("views/activity/add");
        return mv;
    }

   //跳转到avicitvity
    public String toAddActivity() {
        return "views/echarts";
    }

    @RequestMapping("/addActivity")
    @ResponseBody
    public boolean addActivity(HttpServletRequest request, Activity Activity){
        Organizer Organizer = (Organizer)request.getSession().getAttribute("organizer");
        Activity.setFbrq(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        boolean re = false;
        if(Organizer !=null){
            Activity.setOid(Organizer.getId());
            Activity.setOname(Organizer.getRealname());
            service.addActivity(Activity);
            re = true;
        }
        return re;
    }

    @RequestMapping("/deleteActivity")
    public boolean deleteActivity(HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        String id = request.getParameter("id");
        service.deleteActivity(Integer.parseInt(id));
        re = true;
        return re;
    }

    @RequestMapping("/toUpdateActivity")
    public ModelAndView toUpdateActivity(HttpServletRequest request, ModelAndView mv){
        String id=request.getParameter("id");
        Activity Activity = service.selectActivityById(Integer.parseInt(id));
        mv.addObject("Activity", Activity);
        Map map = new HashMap<String,Object>();
        List<Category> categoryList = categoryService.selectCategoryList(map);
        mv.addObject("categoryList", categoryList);
        mv.setViewName("views/activity/update");
        return mv;
    }


    @RequestMapping("/updateActivity")
    @ResponseBody
    public boolean updateActivity(Activity Activity){
        boolean re = false;
        service.updateActivity(Activity);
        re = true;
        return re;
    }
    @RequestMapping("/updateActivityStatus")
    @ResponseBody
    public boolean updateActivityStatus(Activity Activity){
        boolean re = false;
        service.updateActivityStatus(Activity);
        re = true;
        return re;
    }
    @RequestMapping("/stopActivity")
    @ResponseBody
    public boolean stopActivity(Activity Activity){
        boolean re = false;
        service.stopActivity(Activity);
        re = true;
        return re;
    }
    @RequestMapping("/selectActivityStatics")
    public List<Statics> selectActivityStatics(){
        List<Statics> list = service.selectActivityStatics();
        return list;
    }

}

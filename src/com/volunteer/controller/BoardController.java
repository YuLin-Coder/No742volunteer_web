package com.volunteer.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.volunteer.entity.Board;
import com.volunteer.service.BoardService;
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
public class BoardController {

    @Autowired
    BoardService service;

    /**
     * 志愿发起者
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/BoardList")
    public ModelAndView BoardList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        List<Board> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        PageHelper.startPage(currentPage,8);
        list=service.selectBoardList(maps);
        PageInfo<Board> pageInfo=new PageInfo<Board>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/board/list");
    }

    @RequestMapping("/toAddBoard")
    public ModelAndView toAddBoard(HttpServletRequest request, ModelAndView mv){
        mv.setViewName("views/board/add");
        return mv;
    }

    @RequestMapping("/addBoard")
    @ResponseBody
    public boolean addBoard(Board Board){
        Board.setFbsj(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        boolean re = false;
        service.addBoard(Board);
        re = true;
        return re;
    }

    @RequestMapping("/deleteBoard")
    public boolean deleteBoard(HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        String id = request.getParameter("id");
        service.deleteBoard(Integer.parseInt(id));
        re = true;
        return re;
    }

    @RequestMapping("/toUpdateBoard")
    public ModelAndView toUpdateBoard(HttpServletRequest request, ModelAndView mv){
        String id=request.getParameter("id");
        Board Board = service.selectBoardById(Integer.parseInt(id));
        mv.addObject("Board", Board);
        mv.setViewName("views/board/update");
        return mv;
    }


    @RequestMapping("/updateBoard")
    @ResponseBody
    public boolean updateBoard(Board Board){
        boolean re = false;
        service.updateBoard(Board);
        re = true;
        return re;
    }

}

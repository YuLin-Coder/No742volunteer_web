package com.volunteer.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.volunteer.entity.*;
import com.volunteer.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
public class IndexController {
    @Autowired
    ActivityService activityService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    BoardService boardService;

    @Autowired
    UserService userService;

    @Autowired
    BaomingService baomingService;

    @RequestMapping("/toIndex")
    public ModelAndView toIndex(HttpServletRequest request,ModelAndView mv){
        String title = request.getParameter("title");
        Map map = new HashMap<String,Object>();
        map.put("title",title);
        List<Category> categoryList = categoryService.selectCategoryList(map);
        mv.addObject("categoryList", categoryList);
        List<Activity> activityList = activityService.selectActivityList(map);
        mv.addObject("activityList", activityList);
        List<Board> boardList = boardService.selectBoardList(map);
        mv.addObject("boardList", boardList);
        mv.setViewName("views/index/index");
        return mv;
    }


    @RequestMapping("/toBoard")
    public ModelAndView toBoard(HttpServletRequest request,ModelAndView mv){
        String title = request.getParameter("title");
        Map map = new HashMap<String,Object>();
        map.put("title",title);
        List<Category> categoryList = categoryService.selectCategoryList(map);
        mv.addObject("categoryList", categoryList);
        List<Activity> activityList = activityService.selectActivityList(map);
        mv.addObject("activityList", activityList);
        List<Board> boardList = boardService.selectBoardList(map);
        mv.addObject("boardList", boardList);
        mv.setViewName("views/index/board");
        return mv;
    }

    @RequestMapping("/toActivityDetail")
    public ModelAndView toActivityDetail(HttpServletRequest request,ModelAndView mv){
        String aid = request.getParameter("aid");
        Map map = new HashMap<String,Object>();
        List<Category> categoryList = categoryService.selectCategoryList(map);
        mv.addObject("categoryList", categoryList);
        List<Activity> activityList = activityService.selectActivityList(map);
        mv.addObject("activityList", activityList);
        List<Board> boardList = boardService.selectBoardList(map);
        mv.addObject("boardList", boardList);
        Activity activity = activityService.selectActivityById(Integer.parseInt(aid));
        mv.addObject("activity", activity);
        mv.setViewName("views/index/activityDetail");
        return mv;
    }


    @RequestMapping("/toBoardDetail")
    public ModelAndView toBoardDetail(HttpServletRequest request,ModelAndView mv){
        String bid = request.getParameter("bid");
        Map map = new HashMap<String,Object>();
        List<Category> categoryList = categoryService.selectCategoryList(map);
        mv.addObject("categoryList", categoryList);
        List<Activity> activityList = activityService.selectActivityList(map);
        mv.addObject("activityList", activityList);
        List<Board> boardList = boardService.selectBoardList(map);
        mv.addObject("boardList", boardList);
        Board  board = boardService.selectBoardById(Integer.parseInt(bid));
        mv.addObject("board", board);
        mv.setViewName("views/index/boardDetail");
        return mv;
    }


    @RequestMapping("/toIndexLogin")
    public ModelAndView toIndexLogin(HttpServletRequest request,ModelAndView mv){
        mv.setViewName("views/index/login");
        return mv;
    }

    @RequestMapping("/toIndexRegister")
    public ModelAndView toIndexRegister(HttpServletRequest request,ModelAndView mv){
        mv.setViewName("views/index/register");
        return mv;
    }


    @RequestMapping("/outIndex")
    public ModelAndView outIndex(HttpServletRequest request,ModelAndView mv){
        request.getSession().invalidate();
        mv.setViewName("views/index/login");
        return mv;
    }

    @RequestMapping("/toMyInfo")
    public ModelAndView toMyInfo(HttpServletRequest request,ModelAndView mv){
        User user = (User)request.getSession().getAttribute("user");
        User users = userService.selectUserById(user.getId().toString());
        mv.addObject("users", users);
        mv.setViewName("views/index/info");
        return mv;
    }


    @RequestMapping("/toBaoming")
    public ModelAndView toBaoming(HttpServletRequest request,ModelAndView mv){
        User user = (User)request.getSession().getAttribute("user");
        Map<String,Object> maps = new HashMap<>();
        maps.put("uid", user!=null?user.getId():null);
        List<Baoming>  list= baomingService.selectBaomingList(maps);
        request.setAttribute("list",list);
        return new ModelAndView("views/index/baoming");
    }

}

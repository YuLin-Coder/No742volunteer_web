package com.volunteer.controller;

import com.volunteer.entity.Admin;
import com.volunteer.entity.Organizer;
import com.volunteer.entity.User;
import com.volunteer.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class UserController {
    @Autowired
    UserService service;

    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");

    @RequestMapping("/registerUser")
    public ModelAndView registerUser(User user, ModelAndView mv){
     //   user.setTimes(simpleDateFormat.format(new Date()));
      //  service.addUser(user);
        mv.setViewName("view/login");
        return mv;
    }

    @RequestMapping("/login")
    @ResponseBody
    public  String login(@RequestParam("username")String username,
                         HttpServletRequest request, @RequestParam("password")String password, @RequestParam("type")String type,
                         HttpSession session, HttpServletResponse response, ModelAndView mv) throws ServletException, IOException {
        session.removeAttribute("admin");
        session.removeAttribute("user");
        session.removeAttribute("organizer");
        User user =new User();
        Admin admin = new Admin();
        Organizer Organizer = new Organizer();
        request.getSession().setAttribute("type", type);
        String message = "error";
        if(type != null && type.equals("0")){
            admin.setUsername(username);
            admin.setPassword(password);
            Admin admin1 = service.selectAdmin(admin);
            if(admin1 != null){
                request.getSession().setAttribute("admin", admin1);
                message = "ok";
            }
        }else if(type != null && type.equals("1")){//游客
             user.setPhone(username);
             user.setPwd(password);
             user.setRole(type);
             User te = service.selectUser(user);
             if(te != null){
                request.getSession().setAttribute("user", te);
                message = "toIndex";
             }
        }else if(type != null && type.equals("2")){//志愿者
            user.setPhone(username);
            user.setPwd(password);
            user.setRole(type);
            User te = service.selectUser(user);
            if(te != null){
                request.getSession().setAttribute("user", te);
                message = "toIndex";
            }
        }else if(type != null && type.equals("3")){//志愿发起者
            Organizer.setPhone(username);
            Organizer.setPwd(password);
            Organizer Organizers = service.selectOrganizer(Organizer);
            if(Organizers != null){
                request.getSession().setAttribute("organizer", Organizers);
                message = "ok";
            }
        }
        return message;

    }

    /**
     * 游客志愿者列表
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/UserList")
    public ModelAndView UserList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        String status = request.getParameter("status");
        String role = request.getParameter("role");
        List<User> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        maps.put("status", status);
        maps.put("role",role);
        PageHelper.startPage(currentPage,8);
        list=service.selectUserList(maps);
        PageInfo<User> pageInfo=new PageInfo<User>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/user/list");
    }

    @RequestMapping("/toAddUser")
    public ModelAndView toAddUser(HttpServletRequest request, ModelAndView mv){
        mv.setViewName("views/user/add");
        return mv;
    }

    @RequestMapping("/addUser")
    @ResponseBody
    public boolean addUser(User User){
        User.setRegiste_time(new  SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        boolean re = false;
        User user = service.selectUserByUserName(User);
        if(user ==null){
            service.addUser(User);
            re = true;
        }
        return re;
    }

    @RequestMapping("/deleteUser")
    public boolean deleteUser(HttpServletRequest request,
                              HttpServletResponse response){
        boolean re = false;
        String id = request.getParameter("id");
        service.deleteUser(Integer.parseInt(id));
        re = true;
        return re;
    }

    @RequestMapping("/toUpdateUser")
    public ModelAndView toUpdateUser(HttpServletRequest request, ModelAndView mv){
        String id=request.getParameter("id");
        User User = service.selectUserById(id);
        mv.addObject("User", User);
        mv.setViewName("views/user/update");
        return mv;
    }


    @RequestMapping("/updateUser")
    @ResponseBody
    public boolean updateUser(User User){
        boolean re = false;
        service.updateUser(User);
        re = true;
        return re;
    }
    @RequestMapping("/updateUserState")
    @ResponseBody
    public boolean updateUserState(User User){
        boolean re = false;
        service.updateUserState(User);
        re = true;
        return re;
    }

    @RequestMapping("/updateUserInfo")
    @ResponseBody
    public boolean updateUserInfo(HttpServletRequest request,User User){
        boolean re = false;
        service.updateUserInfo(User);
        re = true;
        request.getSession().setAttribute("user",service.selectUserById(User.getId().toString()));
        return re;
    }

    @RequestMapping("/updateUserTx")
    @ResponseBody
    public boolean updateUserTx(HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        String utx = request.getParameter("utx");
        boolean re = false;
        if(user !=null && utx !=null){
            service.updateUserTx(user.getId(),utx);
            user.setTx(utx);
            request.getSession().setAttribute("user",user);
            re = true;
        }
        return re;
    }
    @RequestMapping("/applyUser")
    @ResponseBody
    public boolean applyUser(HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        boolean re = false;
        if(user !=null ){
            service.applyUser(user);
            re = true;
        }
        return re;
    }

}

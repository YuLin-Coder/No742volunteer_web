package com.volunteer.controller;

import com.volunteer.entity.Category;
import com.volunteer.service.CategoryService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
public class CategoryController {

    @Autowired
    CategoryService service;


    @RequestMapping("/CategoryList")
    public ModelAndView CategoryList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        String key = request.getParameter("key");
        List<Category> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        PageHelper.startPage(currentPage,8);
        list=service.selectCategoryList(maps);
        PageInfo<Category> pageInfo=new PageInfo<Category>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/category/list");
    }

    @RequestMapping("/toAddCategory")
    public ModelAndView toAddCategory(HttpServletRequest request, ModelAndView mv){
        mv.setViewName("views/category/add");
        return mv;
    }

    @RequestMapping("/addCategory")
    @ResponseBody
    public boolean addCategory(Category Category){
        boolean re = false;
        service.addCategory(Category);
        re = true;
        return re;
    }


    @RequestMapping("/deleteCategory")
    public boolean deleteCategory(HttpServletRequest request,
                                  HttpServletResponse response){
        boolean re = false;
        String id = request.getParameter("id");
        service.deleteCategory(Integer.parseInt(id));
        re = true;
        return re;
    }

    @RequestMapping("/updateCategory")
    @ResponseBody
    public boolean updateCategory(Category Category){
        boolean re = false;
        service.updateCategory(Category);
        re = true;
        return re;
    }


    @RequestMapping("/toUpdateCategory")
    public ModelAndView toUpdateCategory(HttpServletRequest request, ModelAndView mv){
        String id=request.getParameter("id");
        Category Category = service.selectCategoryById(id);
        mv.addObject("Category", Category);
        mv.setViewName("views/category/update");
        return mv;
    }
}

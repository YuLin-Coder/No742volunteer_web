package com.volunteer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;


@Controller
public class UtilController {

    //跳转至登陆界面
    @RequestMapping("toLogin")
    public String toLogin(HttpSession session) {
        session.removeAttribute("admin");
        session.removeAttribute("user");
        session.removeAttribute("organizer");
        return "views/login";
    }


    @RequestMapping("toLoginOutAct")
    public String toLoginOutAct(HttpSession session) {
        session.removeAttribute("admin");
        session.removeAttribute("user");
        session.removeAttribute("organizer");

        return "views/login";
    }
    //跳转到控制页console.jsp
    @RequestMapping("toConsoleAct")
    public String toWelocmeAct() {
        return "views/console";
    }

    @RequestMapping("toMain")
    public String toMain() {
        return "views/main";
    }

    @RequestMapping("toEcharts")
    public String toEcharts() {
        return "views/echarts";
    }

    //图片上传测试
    @ResponseBody
    @RequestMapping("/upload")
    public Map upload2(MultipartFile file, HttpServletRequest request){

        String prefix="";
        String dateStr="";
        //保存上传
        OutputStream out = null;
        InputStream fileInput=null;
        try{
            if(file!=null){
                String originalName = file.getOriginalFilename();
                prefix=originalName.substring(originalName.lastIndexOf(".")+1);
                Date date = new Date();
                String uuid = UUID.randomUUID()+"";
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                dateStr = simpleDateFormat.format(date);

               //String filepath = "D:\\软件项目\\D-I-ssm项目\\D-I16-志愿者管理系统\\源码\\volunteer_web\\web\\upload\\" + dateStr+"\\"+uuid+"." + prefix;
                String filepath = "D:\\upload\\" + dateStr+"\\"+uuid+"." + prefix;

                File files=new File(filepath);
                //打印查看上传路径
                System.out.println(filepath);
                if(!files.getParentFile().exists()){
                    files.getParentFile().mkdirs();
                }
                file.transferTo(files);
                Map<String,Object> map2=new HashMap<>();
                Map<String,Object> map=new HashMap<>();
                map.put("code",0);
                map.put("msg","");
                map.put("data",map2);
                map2.put("src",dateStr+"/"+uuid+"." + prefix);
                return map;
            }

        }catch (Exception e){
        }finally{
            try {
                if(out!=null){
                    out.close();
                }
                if(fileInput!=null){
                    fileInput.close();
                }
            } catch (Exception e) {
            }
        }
        Map<String,Object> map=new HashMap<>();
        map.put("code",1);
        map.put("msg","");
        return map;

    }
}

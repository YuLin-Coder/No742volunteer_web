package com.volunteer.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.volunteer.entity.*;
import com.volunteer.service.ActivityService;
import com.volunteer.service.BaomingService;
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
public class BaomingController {

    @Autowired
    BaomingService service;

    @Autowired
    ActivityService activityService;

    /**
     * 志愿发起者
     * @param currentPage
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/BaomingList")
    public ModelAndView BaomingList(
            @RequestParam(defaultValue="1") Integer currentPage, HttpServletRequest request,
            Map<String,Object> map){
        User user = (User)request.getSession().getAttribute("user");
        Organizer Organizer = (Organizer)request.getSession().getAttribute("organizer");
        String key = request.getParameter("key");
        String aid = request.getParameter("aid");
        List<Baoming> list = new ArrayList<>();
        Map<String,Object> maps = new HashMap<>();
        maps.put("key", key);
        maps.put("aid", aid);
        maps.put("uid", user!=null?user.getId():null);
        maps.put("oid", Organizer!=null?Organizer.getId():null);
        PageHelper.startPage(currentPage,8);
        list=service.selectBaomingList(maps);
        for(Baoming bb : list){
            bb.setActivity(activityService.selectActivityById(bb.getAid()));
        }
        PageInfo<Baoming> pageInfo=new PageInfo<Baoming>(list,8);
        map.put("pageInfo", pageInfo);
        return new ModelAndView("views/baoming/list");
    }


    @RequestMapping("/addBaoming")
    @ResponseBody
    public String addBaoming(HttpServletRequest request,Baoming Baoming){
        String re = "";
        try {
            request.setCharacterEncoding("UTF-8");
            User user = (User)request.getSession().getAttribute("user");
            Baoming.setActivity(activityService.selectActivityById(Baoming.getAid()));
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            if(user != null ){
                if(user.getRole().equals("2")){
                    Baoming bb = service.selectBaomingByUser(user.getId(),Baoming.getAid());
                    if(bb !=null){
                        re ="a";
                    }else{
                        List<Baoming> baomingList = service.selectBaomingListByUserId(user.getId());
                        boolean isTime =true;
                        for(Baoming baoming1:baomingList){
                            baoming1.setActivity(activityService.selectActivityById(baoming1.getAid()));
                            Date date1 = simpleDateFormat.parse(Baoming.getActivity().getStart_time());
                            Date date2 = simpleDateFormat.parse(Baoming.getActivity().getEnd_time());
                            Date date3 = simpleDateFormat.parse(baoming1.getActivity().getStart_time());
                            Date date4 = simpleDateFormat.parse(baoming1.getActivity().getEnd_time());
                            if(isEffectiveDate(date1,date3,date4)){
                                isTime = false;
                                break;
                            }else if(isEffectiveDate(date2,date3,date4)){
                                isTime = false;
                                break;
                            }else if(isEffectiveDate(date3,date1,date2)){
                                isTime = false;
                                break;
                            }else if(isEffectiveDate(date4,date1,date2)){
                                isTime = false;
                                break;
                            }

                        }
                        if(isTime){
                            Baoming.setCreatetime(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
                            Baoming.setUid(user.getId());
                            Baoming.setUname(user.getRealname());
                            int total = Baoming.getActivity().getTotal();
                            int counts = Baoming.getActivity().getYzmcount();
                            if(total != counts){
                                Date date = new Date();
                                String dates = simpleDateFormat.format(date);
                                if(simpleDateFormat.parse(Baoming.getActivity().getStart_time()).after(simpleDateFormat.parse(dates))){
                                    service.addBaoming(Baoming);
                                    activityService.updateCounts(Baoming.getAid(),Baoming.getActivity().getYzmcount()+1);
                                    re ="b";
                                }else{
                                    re="g";
                                }
                            }else{
                                re ="f";
                            }
                        }else{
                            re ="c";
                        }
                    }

                }else{
                    re = "d";
                }

            }else{
                re = "e";
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return re;
    }

    /**
     * 判断当前时间是否在[startTime, endTime]区间，注意时间格式要一致
     *
     * @param nowTime 当前时间
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @return
     * @author jqlin
     */
    public static boolean isEffectiveDate(Date nowTime, Date startTime, Date endTime) {
        if (nowTime.getTime() == startTime.getTime()
                || nowTime.getTime() == endTime.getTime()) {
            return true;
        }

        Calendar date = Calendar.getInstance();
        date.setTime(nowTime);

        Calendar begin = Calendar.getInstance();
        begin.setTime(startTime);

        Calendar end = Calendar.getInstance();
        end.setTime(endTime);

        if (date.after(begin) && date.before(end)) {
            return true;
        } else {
            return false;
        }
    }

    @RequestMapping("/deleteBaoming")
    public boolean deleteBaoming(HttpServletRequest request,
                                 HttpServletResponse response){
        boolean re = false;
        String id = request.getParameter("id");
        Baoming baoming=service.selectBaomingById(Integer.parseInt(id));
        Activity activity = activityService.selectActivityById(baoming.getAid());
        activityService.updateCounts(activity.getId(),activity.getYzmcount()-1);
        service.deleteBaoming(Integer.parseInt(id));
        re = true;
        return re;
    }

    @RequestMapping("/updateBaomingStatus")
    public boolean updateBaomingStatus(Baoming baoming){
        boolean re = false;
        service.updateBaomingStatus(baoming);
        re = true;
        return re;
    }

    @RequestMapping("/selectBaomingStatics")
    public List<Statics> selectBaomingStatics(){
        List<Statics> list = service.selectBaomingStatics();
        return list;
    }

}

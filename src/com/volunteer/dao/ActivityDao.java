package com.volunteer.dao;

import com.volunteer.entity.Activity;
import com.volunteer.entity.Statics;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author hxh
 * @version V1.00
 * @date 2022/1/10 10:55
 * @since V1.00
 */
public interface ActivityDao {
    List<Activity> selectActivityList(@Param("map") Map<String, Object> maps);
    List<Activity> selectActivityList2(@Param("map") Map<String, Object> maps);
    void addActivity(@Param("Activity") Activity Activity);

    void deleteActivity(@Param("id") Integer parseInt);

    Activity selectActivityById(@Param("id") int id);

    void updateActivity(@Param("Activity") Activity Activity);

    void updateActivityStatus(@Param("Activity") Activity activity);

    void stopActivity(@Param("Activity") Activity activity);

    void updateCounts(@Param("aid") Integer aid,@Param("i")  int i);

    List<Statics> selectActivityStatics();
}

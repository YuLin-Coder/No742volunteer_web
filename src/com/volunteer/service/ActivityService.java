package com.volunteer.service;

import com.volunteer.dao.ActivityDao;
import com.volunteer.entity.Activity;
import com.volunteer.entity.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author hxh
 * @version V1.00
 * @date 2022/1/10 10:55
 * @since V1.00
 */
@Service
public class ActivityService {

    @Autowired
    ActivityDao dao ;

    public List<Activity> selectActivityList(Map<String, Object> maps) {return dao.selectActivityList(maps);
    }

    public List<Activity> selectActivityList2(Map<String, Object> maps) {return dao.selectActivityList2(maps);
    }

    public void addActivity(Activity Activity) {dao.addActivity(Activity);
    }

    public void deleteActivity(int parseInt) {dao.deleteActivity(parseInt);
    }

    public Activity selectActivityById(int id) {return dao.selectActivityById(id);
    }

    public void updateActivity(Activity Activity) {dao.updateActivity(Activity);
    }


    public void updateActivityStatus(Activity activity) {dao.updateActivityStatus(activity);
    }

    public void stopActivity(Activity activity) {dao.stopActivity(activity);
    }

    public void updateCounts(Integer aid, int i) {dao.updateCounts(aid,i);
    }

    public List<Statics> selectActivityStatics() {return dao.selectActivityStatics();
    }
}

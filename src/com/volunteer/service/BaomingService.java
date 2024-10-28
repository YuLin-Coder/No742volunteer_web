package com.volunteer.service;

import com.volunteer.dao.BaomingDao;
import com.volunteer.entity.Baoming;
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
public class BaomingService {

    @Autowired
    BaomingDao dao ;

    public List<Baoming> selectBaomingList(Map<String, Object> maps) {return dao.selectBaomingList(maps);
    }

    public void addBaoming(Baoming Baoming) {dao.addBaoming(Baoming);
    }

    public void deleteBaoming(int parseInt) {dao.deleteBaoming(parseInt);
    }


    public Baoming selectBaomingByUser(Integer id, Integer aid) {return dao.selectBaomingByUser(id,aid);
    }

    public List<Baoming> selectBaomingListByUserId(Integer id) {return dao.selectBaomingListByUserId(id);
    }

    public void updateBaomingStatus(Baoming baoming) {dao.updateBaomingStatus(baoming);
    }

    public Baoming selectBaomingById(int parseInt) {return dao.selectBaomingById(parseInt);
    }

    public List<Statics> selectBaomingStatics() {return dao.selectBaomingStatics();
    }
}

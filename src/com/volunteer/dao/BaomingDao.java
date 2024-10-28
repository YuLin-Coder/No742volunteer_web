package com.volunteer.dao;

import com.volunteer.entity.Baoming;
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
public interface BaomingDao {
    List<Baoming> selectBaomingList(@Param("map") Map<String, Object> maps);

    void addBaoming(@Param("Baoming") Baoming Baoming);

    void deleteBaoming(@Param("id") Integer parseInt);

    Baoming selectBaomingByUser(@Param("id") Integer id,@Param("aid") Integer aid);

    List<Baoming> selectBaomingListByUserId(@Param("id") Integer id);

    void updateBaomingStatus(@Param("baoming") Baoming baoming);

    Baoming selectBaomingById(@Param("id")  int parseInt);

    List<Statics> selectBaomingStatics();
}

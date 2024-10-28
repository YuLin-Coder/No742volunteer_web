package com.volunteer.dao;

import com.volunteer.entity.Board;
import com.volunteer.entity.Organizer;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author hxh
 * @version V1.00
 * @date 2022/1/10 10:55
 * @since V1.00
 */
public interface BoardDao {
    List<Board> selectBoardList(@Param("map") Map<String, Object> maps);

    void addBoard(@Param("Board") Board Board);

    void deleteBoard(@Param("id") Integer parseInt);

    Board selectBoardById(@Param("id") int id);

    void updateBoard(@Param("Board") Board Board);

}

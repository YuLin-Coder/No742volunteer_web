package com.volunteer.service;

import com.volunteer.dao.BoardDao;
import com.volunteer.entity.Board;
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
public class BoardService {

    @Autowired
    BoardDao dao ;

    public List<Board> selectBoardList(Map<String, Object> maps) {return dao.selectBoardList(maps);
    }

    public void addBoard(Board Board) {dao.addBoard(Board);
    }

    public void deleteBoard(int parseInt) {dao.deleteBoard(parseInt);
    }

    public Board selectBoardById(int id) {return dao.selectBoardById(id);
    }

    public void updateBoard(Board Board) {dao.updateBoard(Board);
    }


}

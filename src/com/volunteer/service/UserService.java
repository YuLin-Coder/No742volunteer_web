package com.volunteer.service;

import com.volunteer.dao.UserDao;
import com.volunteer.entity.Admin;
import com.volunteer.entity.Organizer;
import com.volunteer.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author hxh
 * @version V1.00
 * @date 2021/12/29 16:17
 * @since V1.00
 */
@Service
public class UserService {

    @Autowired
    UserDao dao;

    public void addUser(User user) {
        dao.addUser(user);
    }

    public Admin selectAdmin(Admin admin) {return dao.selectAdmin(admin);
    }

    public User selectUser(User user) {return dao.selectUser(user);
    }

    public List<User> selectUserList(Map<String, Object> maps) {return dao.selectUserList(maps);
    }

    public void deleteUser(int parseInt) { dao.deleteUser(parseInt);
    }

    public User selectUserById(String id) {return dao.selectUserById(Integer.parseInt(id));
    }

    public void updateUser(User user) { dao.updateUser(user);
    }

    public User selectUserByUserName(User user) {return dao.selectUserByUserName(user);
    }

    public Organizer selectOrganizer(Organizer organizer) {return dao.selectOrganizer(organizer);
    }

    public void updateUserState(User user) {dao.updateUserState(user);
    }

    public void updateUserTx(Integer id, String utx) {dao.updateUserTx(id,utx);
    }

    public void updateUserInfo(User user) {dao.updateUserInfo(user);
    }

    public void applyUser(User user) {dao.applyUser(user);
    }
}

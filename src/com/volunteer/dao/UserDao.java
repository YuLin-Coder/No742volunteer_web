package com.volunteer.dao;

import com.volunteer.entity.Admin;
import com.volunteer.entity.Organizer;
import com.volunteer.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author hxh
 * @version V1.00
 * @date 2021/12/29 16:17
 * @since V1.00
 */
public interface UserDao {
    void addUser(@Param("User") User User);

    Admin selectAdmin(@Param("admin") Admin admin);

    User selectUser(@Param("User") User User);

    List<User> selectUserList(@Param("map") Map<String, Object> maps);

    void deleteUser(@Param("id") int parseInt);

    User selectUserById(@Param("id") int parseInt);

    void updateUser(@Param("User") User User);

    User selectUserByUserName(@Param("User") User user);

    Organizer selectOrganizer(@Param("organizer") Organizer organizer);

    void updateUserState(@Param("User") User user);

    void updateUserTx(@Param("id") Integer id,@Param("utx") String utx);

    void updateUserInfo(@Param("User") User user);

    void applyUser(@Param("User") User user);
}

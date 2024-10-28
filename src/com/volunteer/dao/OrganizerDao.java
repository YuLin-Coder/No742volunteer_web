package com.volunteer.dao;

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
public interface OrganizerDao {
    List<Organizer> selectOrganizerList(@Param("map") Map<String, Object> maps);

    Organizer selectOrganizerByOrganizerName(@Param("Organizer") Organizer organizer);

    void addOrganizer(@Param("Organizer") Organizer organizer);

    void deleteOrganizer(@Param("id")Integer parseInt);

    Organizer selectOrganizerById(@Param("id")int id);

    void updateOrganizer(@Param("Organizer") Organizer organizer);

    void updateOrganizerState(@Param("Organizer") Organizer organizer);
}

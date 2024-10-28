package com.volunteer.service;

import com.volunteer.dao.OrganizerDao;
import com.volunteer.entity.Organizer;
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
public class OrganizerService {

    @Autowired
    OrganizerDao dao ;

    public List<Organizer> selectOrganizerList(Map<String, Object> maps) {return dao.selectOrganizerList(maps);
    }

    public Organizer selectOrganizerByOrganizerName(Organizer organizer) {return dao.selectOrganizerByOrganizerName(organizer);
    }

    public void addOrganizer(Organizer organizer) {dao.addOrganizer(organizer);
    }

    public void deleteOrganizer(int parseInt) {dao.deleteOrganizer(parseInt);
    }

    public Organizer selectOrganizerById(int id) {return dao.selectOrganizerById(id);
    }

    public void updateOrganizer(Organizer organizer) {dao.updateOrganizer(organizer);
    }

    public void updateOrganizerState(Organizer organizer) {dao.updateOrganizerState(organizer);
    }
}

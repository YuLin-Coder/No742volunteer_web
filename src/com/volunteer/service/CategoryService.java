package com.volunteer.service;

import com.volunteer.dao.CategoryDao;
import com.volunteer.entity.Category;
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
public class CategoryService {

    @Autowired
    CategoryDao dao;

    public void addCategory(Category Category) {
        dao.addCategory(Category);
    }

 
    public List<Category> selectCategoryList(Map<String, Object> maps) {return dao.selectCategoryList(maps);
    }

    public void deleteCategory(int parseInt) { dao.deleteCategory(parseInt);
    }

    public Category selectCategoryById(String id) {return dao.selectCategoryById(Integer.parseInt(id));
    }

    public void updateCategory(Category Category) { dao.updateCategory(Category);
    }


}

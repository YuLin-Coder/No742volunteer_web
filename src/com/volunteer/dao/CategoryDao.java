package com.volunteer.dao;

import com.volunteer.entity.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author hxh
 * @version V1.00
 * @date 2021/12/30 19:54
 * @since V1.00
 */
public interface CategoryDao {

    void addCategory(@Param("Category") Category Category);

    List<Category> selectCategoryList(@Param("map") Map<String, Object> maps);

    void deleteCategory(@Param("id") int parseInt);

    Category selectCategoryById(@Param("id") int parseInt);

    void updateCategory(@Param("Category") Category Category);

}

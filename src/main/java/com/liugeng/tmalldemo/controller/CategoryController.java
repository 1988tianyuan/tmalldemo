package com.liugeng.tmalldemo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.liugeng.tmalldemo.pojo.Category;
import com.liugeng.tmalldemo.service.CategoryService;
import com.liugeng.tmalldemo.utils.ImageUtil;
import com.liugeng.tmalldemo.utils.Page;
import com.liugeng.tmalldemo.utils.UploadImageFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("")
public class CategoryController {
    @Autowired
    CategoryService categoryService;

    @RequestMapping("admin_category_list")
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Category> categories = categoryService.list();
        int total = (int) new PageInfo<>(categories).getTotal();
        page.setTotal(total);
        model.addAttribute("cs",categories);
        model.addAttribute("page",page);
        return "admin/listCategory";
    }

    @RequestMapping("admin_category_add")
    public String add(HttpServletRequest request, Category category, UploadImageFile file) throws IOException,IllegalStateException{
        categoryService.add(category);

        File newFile = new File(request.getServletContext().getRealPath("img/category"), category.getId()+".jpg");
        if(!newFile.getParentFile().exists()) newFile.getParentFile().mkdirs();
        file.getImage().transferTo(newFile);
        //获取上传的Mutipart文件并保存到指定地址

        BufferedImage image = ImageUtil.change2jpg(newFile);
        ImageIO.write(image, "jpg", newFile);
        //这两个操作确保上传的文件被正确转换为jpg文件

        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_category_delete")
    public String delete(@RequestParam("id")int id, HttpServletRequest request){
        categoryService.delete(id);

        File imageFolder = new File(request.getServletContext().getRealPath("img/category"));
        File imageNeedDeleted = new File(imageFolder, id+".jpg");
        if(null != imageNeedDeleted){
            imageNeedDeleted.delete();
        }
        return "redirect:/admin_category_list";
    }

    @RequestMapping("admin_category_edit")
    public String edit(@RequestParam("id")int id, Model model){
        Category category = categoryService.get(id);
        model.addAttribute("category",category);
        return "admin/editCategory";
    }

    @RequestMapping("admin_category_update")
    public String update(HttpServletRequest request, Category category, UploadImageFile file) throws IOException,IllegalStateException{
        categoryService.update(category);

        File oldFile = new File(request.getServletContext().getRealPath("img/category"), category.getId()+".jpg");
        file.getImage().transferTo(oldFile);
        //获取上传的Mutipart文件并保存到指定地址

        BufferedImage image = ImageUtil.change2jpg(oldFile);
        ImageIO.write(image, "jpg", oldFile);
        //这两个操作确保上传的文件被正确转换为jpg文件

        return "redirect:/admin_category_list";
    }
}

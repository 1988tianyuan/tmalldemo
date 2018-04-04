package com.liugeng.tmalldemo.controller;

import com.liugeng.tmalldemo.pojo.Product;
import com.liugeng.tmalldemo.pojo.ProductImage;
import com.liugeng.tmalldemo.service.ProductImageService;
import com.liugeng.tmalldemo.service.ProductService;
import com.liugeng.tmalldemo.utils.ImageUtil;
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
public class ProductImageController {
    @Autowired
    ProductImageService productImageService;
    @Autowired
    ProductService productService;

    @RequestMapping("admin_productImage_list")
    public String listProductImage(@RequestParam("pid")int pid, Model model){
        Product product = productService.get(pid);
        List<ProductImage> productImageSingleList = productImageService.list(pid, ProductImageService.type_single);
        List<ProductImage> productImageDetailList = productImageService.list(pid, ProductImageService.type_detail);
        model.addAttribute("productImageSingleList", productImageSingleList);
        model.addAttribute("productImageDetailList", productImageDetailList);
        model.addAttribute("product", product);
        return "admin/listProductImage";
    }

    @RequestMapping("admin_productImage_add")
    public String addProductImage(ProductImage productImage, UploadImageFile uploadImageFile, HttpServletRequest request){
        System.out.println(productImage.getType());
        productImageService.add(productImage);

        String image_original_path, image_middle_path = null, image_small_path = null;
        String imageFileName = productImage.getId()+".jpg";

        //根据上传文件类型的不同，指定不同的存储地址（single和detail需要存储不同的路径,single图片需要存为原图、中型和小型三种图片形式）
        if(ProductImageService.type_single.equals(productImage.getType())){
            image_original_path = request.getServletContext().getRealPath("img/ps_original");
            image_middle_path = request.getServletContext().getRealPath("img/ps_middle");
            image_small_path = request.getServletContext().getRealPath("img/ps_small");
        }else{
            image_original_path = request.getServletContext().getRealPath("img/p_detail");
        }

        File newFileOriginal = new File(image_original_path, imageFileName);
        newFileOriginal.getParentFile().mkdirs();
        System.out.println(newFileOriginal.getAbsolutePath());
        try{
            newFileOriginal.createNewFile();
            uploadImageFile.getImage().transferTo(newFileOriginal);
            //获取上传的Mutipart文件并拷贝到指定地址（原图）

            BufferedImage image = ImageUtil.change2jpg(newFileOriginal);
            ImageIO.write(image, "jpg", newFileOriginal);
            //这两个操作确保上传的文件被正确转换为jpg文件
        }catch (IOException e){
            e.printStackTrace();
        }

        if(ProductImageService.type_single.equals(productImage.getType())){
            File newFileSingleMiddle = new File(image_middle_path, imageFileName);
            ImageUtil.resizeImage(newFileOriginal, 217, 190, newFileSingleMiddle);
            //将原图拷贝一份，转换大小并另存为中型尺寸

            File newFileSingleSmall = new File(image_small_path, imageFileName);
            ImageUtil.resizeImage(newFileOriginal, 56, 56, newFileSingleSmall);
            //将原图拷贝一份，转换大小并另存为小型尺寸
        }

        return "redirect:admin_productImage_list?pid=" + productImage.getPid();
    }

    @RequestMapping("admin_productImage_delete")
    public String deleteProductImage(@RequestParam("id")int id, HttpServletRequest request){
        ProductImage productImage = productImageService.get(id);

        String imageFileName = id +".jpg";
        String image_original_path, image_middle_path, image_small_path;

        if(ProductImageService.type_single.equals(productImage.getType())){
            image_original_path = request.getServletContext().getRealPath("img/ps_original");
            image_middle_path = request.getServletContext().getRealPath("img/ps_middle");
            image_small_path = request.getServletContext().getRealPath("img/ps_small");

            File imageMiddleNeedDeleted = new File(new File(image_middle_path), imageFileName);
            if(imageMiddleNeedDeleted != null){
                imageMiddleNeedDeleted.delete();
            }

            File imageSmallNeedDeleted = new File(new File(image_small_path), imageFileName);
            if(imageSmallNeedDeleted != null){
                imageSmallNeedDeleted.delete();
            }
        }else{
            image_original_path = request.getServletContext().getRealPath("img/p_detail");
        }

        File imageOriginalNeedDeleted = new File(new File(image_original_path), imageFileName);
        if(imageOriginalNeedDeleted != null){
            imageOriginalNeedDeleted.delete();
        }

        productImageService.delete(id);

        return "redirect:admin_productImage_list?pid=" + productImage.getPid();
    }
}

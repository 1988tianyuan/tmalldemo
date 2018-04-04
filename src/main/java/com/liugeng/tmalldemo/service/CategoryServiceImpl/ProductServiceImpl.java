package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.CategoryMapper;
import com.liugeng.tmalldemo.mapper.ProductMapper;
import com.liugeng.tmalldemo.pojo.Product;
import com.liugeng.tmalldemo.pojo.ProductExample;
import com.liugeng.tmalldemo.pojo.ProductImage;
import com.liugeng.tmalldemo.service.CategoryService;
import com.liugeng.tmalldemo.service.ProductImageService;
import com.liugeng.tmalldemo.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService{

    @Autowired
    ProductMapper productMapper;
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductImageService productImageService;

    @Override
    public void add(Product product) {
        productMapper.insertSelective(product);
    }

    @Override
    public void delete(int pid) {
        productMapper.deleteByPrimaryKey(pid);
    }

    @Override
    public void update(Product product) {
        productMapper.updateByPrimaryKeySelective(product);
    }

    @Override
    public Product get(int pid) {
        Product product = productMapper.selectByPrimaryKey(pid);
        setCategory(product);
        setProductImageService(product);
        return product;
    }

    @Override
    public List<Product> list(int cid) {
        ProductExample productExample = new ProductExample();
        ProductExample.Criteria criteria = productExample.createCriteria();
        criteria.andCidEqualTo(cid);
        productExample.setOrderByClause("id ASC");
        List<Product> result = productMapper.selectByExample(productExample);
        setCategory(result);
        return result;
    }

    @Override
    public void setFirstProductImage(List<Product> products) {
        for(Product product:products){
            setProductImageService(product);
        }
    }

    void setProductImageService(Product product){
        List<ProductImage> productFirstImageList = productImageService.list(product.getId(), ProductImageService.type_single);
        if(!productFirstImageList.isEmpty()){
            product.setProductFirstImage(productFirstImageList.get(0));
        }
    }

    void setCategory(Product product){
        product.setCategory(categoryService.get(product.getCid()));
    }

    void setCategory(List<Product> products){
        for(Product product:products){
            setCategory(product);
        }
    }
}

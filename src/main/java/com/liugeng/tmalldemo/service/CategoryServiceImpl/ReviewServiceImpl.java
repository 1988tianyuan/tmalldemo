package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.ReviewMapper;
import com.liugeng.tmalldemo.pojo.Review;
import com.liugeng.tmalldemo.pojo.ReviewExample;
import com.liugeng.tmalldemo.pojo.User;
import com.liugeng.tmalldemo.service.ReviewService;
import com.liugeng.tmalldemo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    ReviewMapper reviewMapper;
    @Autowired
    UserService userService;

    @Override
    public void add(Review review) {
        reviewMapper.insert(review);
    }

    @Override
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Review review) {
        reviewMapper.updateByPrimaryKeySelective(review);
    }

    @Override
    public Review get(int id) {
        return reviewMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Review> list(int pid) {
        ReviewExample reviewExample = new ReviewExample();
        reviewExample.createCriteria().andPidEqualTo(pid);
        reviewExample.setOrderByClause("id ASC");
        List<Review> reviews = reviewMapper.selectByExample(reviewExample);
        setUser(reviews);
        return reviews;
    }

    @Override
    public int getCount(int pid) {
        return list(pid).size();
    }

    void setUser(Review review){
        User user = userService.get(review.getUid());
        user.setAnonymousName();
        review.setUser(user);
    }

    void setUser(List<Review> reviews){
        for(Review review:reviews){
            setUser(review);
        }
    }

}

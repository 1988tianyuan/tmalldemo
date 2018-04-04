package com.liugeng.tmalldemo.utils;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.*;
import java.io.File;
import java.io.IOException;

public class ImageUtil {

    public static BufferedImage change2jpg(File file){
        try{
            Image image = Toolkit.getDefaultToolkit().createImage(file.getAbsolutePath());
            PixelGrabber pixelGrabber = new PixelGrabber(image,0,0,-1,-1,true);
            pixelGrabber.grabPixels();
            int width = pixelGrabber.getWidth(), height = pixelGrabber.getHeight();
            final int[] RGB_MASKS = {0xFF0000, 0xFF00, 0xFF};
            final ColorModel RGB_OPAQUE = new DirectColorModel(32, RGB_MASKS[0], RGB_MASKS[1], RGB_MASKS[2]);
            DataBuffer dataBuffer = new DataBufferInt((int[])pixelGrabber.getPixels(), width * height);
            WritableRaster raster = Raster.createPackedRaster(dataBuffer, width, height, width, RGB_MASKS, null);
            BufferedImage bufferedImage = new BufferedImage(RGB_OPAQUE, raster, false, null);
            return bufferedImage;
        }catch (InterruptedException e){
            e.printStackTrace();
            return null;
        }
    }

    public static void resizeImage(File originalFile, int width, int height, File destiFile){
        destiFile.getParentFile().mkdirs();

        try{
            destiFile.createNewFile();
            Image originalImage = ImageIO.read(originalFile);
            originalImage = resizeImage(originalImage, width, height);
            ImageIO.write((RenderedImage)originalImage, "jpg", destiFile);
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    public static Image resizeImage(Image originalImage, int width, int height){
        try{
            BufferedImage destiImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            destiImage.getGraphics().drawImage(originalImage.getScaledInstance(width, height, Image.SCALE_SMOOTH), 0 , 0, null);
            return destiImage;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

}

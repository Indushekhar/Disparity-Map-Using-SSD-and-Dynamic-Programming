clc
clear all

left=imread('tsukuba_l.png');
right=imread('tsukuba_r.png');
left_I=mean(left,3);
right_I=mean(right,3);
I_disp=zeros(size(left_I),'single');
disp_range=45;
h_block_size=5;
blocksize=h_block_size*2+1;
row=size(left_I,1);
col=size(left_I,2);

for m =1:row
    row_min= max(1, m- h_block_size);
    row_max= min(row, m+ h_block_size);
    
    for n =1:col
          col_min= max(1,n-h_block_size);
          col_max= min(col,n+h_block_size);
          %% setting the pixel search limit
        
          pix_min= max(-disp_range, 1 - col_min);
          pix_max= min(disp_range, col - col_max);
          
          template = right_I(row_min:row_max ,col_min:col_max);
          
          block_count= pix_max - pix_min + 1;
          block_diff= zeros(block_count, 1);
          
          for i = pix_min : pix_max
              block= left_I(row_min:row_max ,(col_min +i ):(col_max+i));
              index= i-pix_min+1;
              block_diff(index,1)= sumsqr(template - block);
              
          end
          [B,I]= sort(block_diff);
          match_index= I(1,1);
          disparity= match_index+pix_min-1;
          I_disp(m, n) = disparity;
    end
end

imshow(I_disp);
colormap jet;
colorbar ;
caxis([0 15]);
title('Depth map from  block matching');
colormapeditor

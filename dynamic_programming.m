clc
clear all

left_I=imread('tsukuba_l.png');
right_I=imread('tsukuba_r.png');
left_I=mean(left_I,3);
right_I=mean(right_I,3);
I_disp=zeros(size(left_I), 'single');
disp_range=55;
h_block_size=9;
blocksize=h_block_size*2+1;
row=size(left_I,1);
col=size(left_I,2);
min_diff= Inf;
disp_cost= min_diff*ones(col,2*disp_range+1,'single');
penalty=0.4;


for m =1:row
    disp_cost(:)= min_diff;
    row_min= max(1, m- h_block_size);
    row_max= min(row, m+ h_block_size);
    
    for n =1:col
          col_min= max(1,n-h_block_size);
          col_max= min(col,n+h_block_size);
          %% setting the pixel search limit
          pix_min= max(-disp_range, 1 - col_min);
          pix_max= min(disp_range, col - col_max);
         
          for i = pix_min : pix_max
              disp_cost(n,i+disp_range+1)=sumsqr(left_I(row_min:row_max ,(col_min :col_max)+i)-right_I(row_min:row_max ,col_min:col_max));
             
          end
    end
  Index= zeros(size(disp_cost), 'single');
  	c_p = disp_cost(end, :);
    for j = col-1:-1:1
           diff = (col - j + 1) *min_diff;
     [z,inx] = min([diff diff c_p(1:end-4)+3*penalty;
                      diff c_p(1:end-3)+2*penalty;
                      c_p(1:end-2)+penalty;
                      c_p(2:end-1);
                      c_p(3:end)+penalty;
                      c_p(4:end)+4*penalty diff;
                      c_p(5:end)+5*penalty diff diff],[],1);
                  c_p = [diff disp_cost(j,2:end-1)+z diff];
        Index(j, 2:end-1) = (2:size(disp_cost,2)-1) + (inx - 4);
    end
	
    [~,inx] = min(c_p);
    I_disp(m,1) = inx;
   
	for (k = 1:(col-1))
		I_disp(m,k+1) = Index(k,max(1, min(size(Index,2), round(I_disp(m,k)) ) ) );
    end
end

I_disp = I_disp - disp_range- 1;
figure(1), clf;
imshow(I_disp,[]), axis image, colormap('jet'), colorbar;
caxis([0 15]);
title('Block matching with Dynamic programming');
colormapeditor
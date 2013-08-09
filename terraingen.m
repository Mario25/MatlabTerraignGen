function y=terraingen(r,c,rounding,rivers)

out='Initialising terraign'
y=rand(r,c);
out='flattening terraign'
y=flattengrad8(y,rounding);
put='making rivers'
for trash=1:rivers
   y=river(y); 
end
out='printing'
figure(1)
surf(y);figure(gcf);
figure(2)
contour(y);figure(gcf);
out='done'
end


function y=river(x)
    [r,c]=size(x);
    y=x;
    %currx=round(mod(rand()*10000,r-2)+2);
    %curry=round(mod(rand()*10000,c-2)+2);
    [currx,curry]=highLowPoint(x,1);
    old=[-1,-1];
    [min,max]=arrayminmax(y);
    diff=abs(max-min)/2.5;
    count=0;
    pond=0;
    riverarr(r,c)=0;
    while (currx<r-1&&currx>=2&&curry<c-1&&curry>=2&&pond==0)
      old=[old;currx,curry];
      riverarr(currx,curry)=riverarr(currx,curry)+diff;
      nextval=inf;
      for i=-1:2:1
          for j=-1:2:1
              pond=0;
                for m=1:count+2
                    if(old(m,1)==i+currx)&&(old(m,2)==j+curry)
                         pond=1;
                     end 
                end
              if ((y(i+currx,j+curry)<nextval)&&(i~=0)&&(i~=0)&&pond==0)
                 nextx=i+currx;
                 nexty=j+curry;
                 nextval=y(i+currx,j+curry);
              end
          end

      end
      count=count+1;
      currx=nextx;
      curry=nexty;

    end
    riverarr=flattengrad8(riverarr,1);
    y=y-riverarr;
end



function [x,y] = highLowPoint(a,hl)
    [r,c]=size(a);
    currx=round(mod(rand()*10000,r-2)+2);
    curry=round(mod(rand()*10000,c-2)+2);
    nextx=currx-1;
    nexty=curry-1;
    nextval=-inf;
    while(nextx~=currx&&nexty~=curry&&currx>10&&curry>10&&currx<r-10&&curry<c-10)
        nextx=currx;
        nexty=curry;
        for i=-5:5
          for j=-5:5
              if (((a(i+currx,j+curry)>nextval)&&hl==1)||((a(i+currx,j+curry)<nextval)&&hl==-1))
                 nextx=i+currx;
                 nexty=j+curry;
                 nextval=a(i+currx,j+curry);
              end
          end
        end
        
    end
    x=currx;
    y=curry;
end


function y=flattengrad8(x,n)
    [r,c]=size(x);
    
    for count=1:n
        for j=2:c-1
            for i=2:r-1
                x(i,j)=(x(i-1,j)+x(i+1,j)+x(i,j+1)+x(i,j-1)+x(i+1,j+1)+x(i+1,j-1)+x(i-1,j+1)+x(i-1,j-1))/8;
            end
        end
    for j=1:((r+c)/2)
         x(1,j)=x(r/2,c/2);
         x(j,1)=x(r/2,c/2);
         x(j,c)=x(r/2,c/2);
         x(r,j)=x(r/2,c/2);
    end
    surf(x);figure(gcf);
    y=x;
    end
    
end


function [min,max] = arrayminmax(x)
   [r,c]=size(x);
    y=x;
    max=-inf;
    min=inf;
    for i=1:r
        for j=1:c
            if x(i,j)>max
                max=x(i,j);
            end
            if x(i,j)<min
                min=x(i,j);
            end
        end
    end
end




function [maxx,maxy] = maxxy(x)
   [r,c]=size(x);
    max=-inf;
    for i=1:r
        for j=1:c
            if x(i,j)>max
                max=x(i,j);
                maxx=i;
                maxy=j;
            end
        end
    end
end


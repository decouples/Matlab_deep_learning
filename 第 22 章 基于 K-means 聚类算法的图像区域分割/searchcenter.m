function [center]=searchcenter(X,kratio)
[n,~]=size(X);
isleft=true(n,1);
count=zeros(n,1);
center=[];
kind=0;
dist=0;
for i=1:n
    for j=i+1:n
        dist=dist+weightdist(X(i,:),X(j,:));
    end
end
dist=dist/((n-1)*(n-1)/2);
radius1=dist*kratio(1);
radius2=dist*kratio(2);
while any(isleft)
    for i=1:n
        count(i)=0;
        if isleft(i)       
            for j=1:n
                if isleft(j)
                    dist=weightdist(X(i,:),X(j,:));
                    count(i)=count(i) + dist<=radius1;
                end
            end
        end
    end
    [~,locs]=max(count);
    iscenter=true;
    for i=1:kind
        dist=weightdist(X(locs,:),center(i,:));
        iscenter=iscenter && dist>=radius2;
        if ~iscenter
            break;
        end
    end
    if iscenter
        kind=kind+1;
        center(end+1,:)=X(locs,:);
        for i=1:n
            if isleft(i)
                dist=weightdist(X(i,:),X(locs,:));
                if  dist <= radius1
                    isleft(i)=false;    
                end
            end        
        end        
    else
        isleft(locs)=false;
    end
end
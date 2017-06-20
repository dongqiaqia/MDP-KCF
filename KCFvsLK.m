function [  ] = KCFvsLK( tracker,fr,dres_gt )
%KCFVSLK Summary of this function goes here
%   Detailed explanation goes here% check if any detection overlap with gt
index = find(dres_gt.fr == fr);
gx1 = dres_gt.x(index);
gx2 = dres_gt.x(index)+dres_gt.w(index)-1;
gy1 = dres_gt.y(index);
gy2 = dres_gt.y(index)+dres_gt.h(index)-1;

lkx1 = tracker.lk_bb(1);
lkx2 = tracker.lk_bb(3);
lky1 = tracker.lk_bb(2);
lky2 = tracker.lk_bb(4);

kcfx1 = tracker.kcf_bb(1);
kcfx2 = tracker.kcf_bb(3);
kcfy1 = tracker.kcf_bb(2);
kcfy2 = tracker.kcf_bb(4);

ga = dres_gt.w(index)*dres_gt.h(index);
lka = (lkx2-lkx1)*(lky2-lky1);
kcfa = (kcfx2-kcfx1)*(kcfy2-kcfy1);


%%% find the overlapping area
xx1 = max(lkx1, gx1);
yy1 = max(lky1, gy1);
xx2 = min(lkx2, gx2);
yy2 = min(lky2, gy2);
w = xx2-xx1+1;
h = yy2-yy1+1;
if(w>0&&h>0)
    inter = w*h;
    u = lka + ga - inter;
    lkov = inter/u;
else
    lkov = 0;
end

xx1 = max(kcfx1, gx1);
yy1 = max(kcfy1, gy1);
xx2 = min(kcfx2, gx2);
yy2 = min(kcfy2, gy2);
w = xx2-xx1+1;
h = yy2-yy1+1;
if(w>0&&h>0)
    inter = w*h;
    u = kcfa + ga - inter;
    kcfov = inter/u;
else
    kcfov = 0;
end
fprintf('the lk overlap is:%f\n',lkov);
fprintf('the kcf overlap is:%f\n',kcfov);

end


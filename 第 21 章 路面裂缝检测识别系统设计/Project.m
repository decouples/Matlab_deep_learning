function [projectr, projectc] = Project(bw)
projectr = sum(bw, 2);
projectc = sum(bw, 1); 

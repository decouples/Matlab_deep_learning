function cn = AddNode(co, tmp)
cn = cell(size(co));
for i = 1:length(co)
    cn{i} = [tmp co{i}];
end
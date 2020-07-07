function [data,test] = rare_category(data,test,cnt)
%All the Blanks and count less than cnt data
%are grouped in a category called "Rare"

cnt=200;
index_test=isundefined(test);
index=isundefined(data);
%Renaming Blanks to Rare
data(index)=categorical("Rare");
test(index_test)=categorical("Rare");

count=countcats(data); 
category=categories(data);
j=1;
for i=1:length(count)
    if(count(i)<cnt)
        a{1,j}=category{i,1};
        j=j+1;
    end       
end
%Renaming count less than "cnt" to Rare
new_cat = mergecats(data,a,'Rare');
data=new_cat;
new_cat_test = mergecats(test,a,'Rare');
test=new_cat_test;

end
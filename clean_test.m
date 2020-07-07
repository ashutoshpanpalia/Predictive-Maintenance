function [test, dataset] = clean_test(test , dataset)



%data cleaning of gps_height
%Replacing negative height with average height after removing negative(1060.32)
%for i=1:59400
%   if(gps_height<0)
%        gps_height(i)=1060.32;
%    end
%end

dataset.gps_height(dataset.gps_height<0)=1060.32;
test.gps_height(test.gps_height<0)=1060.32;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data cleaning of latitude
%Replacing latitude greater than -0.9(max latitude) with -6.37
test.latitude(test.latitude>-0.9)=-6.37;
for i=1:59400
    if(dataset.latitude(i)>-0.9)
        dataset.latitude(i)=-6.37;
           
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data cleaning of longitude
%Replacing longitude less than 29.3(max latitude) with 34.89
for i=1:59400
    if(dataset.longitude(i)<29.3)
        dataset.longitude(i)=34.89;
        
    end
end
test.longitude(test.longitude<29.3)=34.89;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data cleaning for date_recorded 
%Using only months and date
dataset.date_recorded = char(dataset.date_recorded);
dataset.date_recorded = categorical(string(dataset.date_recorded(:,4:10)));

test.date_recorded = char(test.date_recorded);
test.date_recorded = categorical(string(test.date_recorded(:,4:10)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Data cleaning for funder
%target to Group 0, blank and count<60 to Rare

%Renaming 0 to Rare
dataset.funder=renamecats(dataset.funder,'0','Rare');
test.funder=renamecats(test.funder,'0','Rare');

%Index of Blank/Not Defined funder
index=isundefined(dataset.funder);
index_test=isundefined(test.funder);
%Renaming Blanks to Rare
dataset.funder(index)=categorical("Rare");
test.funder(index_test)=categorical("Rare");
%Finding categories that have less than 0.1% count i.e 60
count=countcats(dataset.funder); 
category=categories(dataset.funder);
j=1;
for i=1:length(count)
    if(count(i)<200)
        a{1,j}=category{i,1};
        j=j+1;
    end       
end
%Replacing less than 60 count and 0 category with Rare 
% "a" is a cell array with all the categories to be combined as Rare
new_cat = mergecats(dataset.funder,a,'Rare');
dataset.funder=new_cat;
new_cat_test = mergecats(test.funder,a,'Rare');
test.funder=new_cat_test;


%%%%%%%%%%%%%%%%%
%Data cleaning of Installer
dataset.installer=renamecats(dataset.installer,'0','Rare');
test.installer=renamecats(test.installer,'0','Rare');

%Function made to group all the rare categories used 
[dataset.installer,test.installer]=rare_category(dataset.installer,test.installer,60);



%Data cleaning of wpt_name
dataset.wpt_name=categorical(dataset.wpt_name);
dataset.wpt_name=renamecats(dataset.wpt_name,'none','Rare');
test.wpt_name=categorical(test.wpt_name);
test.wpt_name=renamecats(test.wpt_name,'none','Rare');


%Function made to group all the rare categories used 

[dataset.wpt_name,test.wpt_name]=rare_category(dataset.wpt_name,test.wpt_name,60);

%Data cleaning of subvillage

%Function made to group all the rare categories used for subvillage
dataset.subvillage=categorical(dataset.subvillage);
test.subvillage=categorical(test.subvillage);

[dataset.subvillage,test.subvillage]=rare_category(dataset.subvillage,test.subvillage,60);


%Function made to group all the rare categories used for ward 
dataset.ward=categorical(dataset.ward);
test.ward=categorical(test.ward);
[dataset.ward,test.ward]=rare_category(dataset.ward,test.ward,60);


%Function made to group all the rare categories used for public_meeting 
index=isundefined(dataset.public_meeting);
index_test=isundefined(test.public_meeting);
%Renaming Blanks to Rare
dataset.public_meeting(index)=categorical("Missing");
test.public_meeting(index_test)=categorical("Missing");

%Data cleaning for scheme_management

[dataset.scheme_management,test.scheme_management]=rare_category(dataset.scheme_management,test.scheme_management,60);


%Data cleaning of permit
index=isundefined(dataset.permit);
index_test=isundefined(test.permit);
%Renaming Blanks to Rare
dataset.permit(index)=categorical("Missing");
test.permit(index_test)=categorical("Missing");



%Data Cleaning for construction_year
dataset.construction_year(dataset.construction_year==0)=1987;
test.construction_year(test.construction_year==0)=1987;


%Data Cleaning for management
dataset.management = mergecats(dataset.management,{'other','other - school','unknown'},'Rare');
test.management = mergecats(test.management,{'other','other - school','unknown'},'Rare');

%Data cleaning for management_group
dataset.management_group = mergecats(dataset.management_group,{'other','unknown'},'Rare');
test.management_group = mergecats(test.management_group,{'other','unknown'},'Rare');


%Data cleaning for payment
dataset.payment = mergecats(dataset.payment,{'other','unknown'},'Rare');
test.payment = mergecats(test.payment,{'other','unknown'},'Rare');


%Data cleaning for payment
dataset.payment_type = mergecats(dataset.payment_type,{'other','unknown'},'Rare');
test.payment_type = mergecats(test.payment_type,{'other','unknown'},'Rare');

%Data cleaning for source
dataset.source = mergecats(dataset.source,{'other','unknown'},'Rare');
test.source = mergecats(test.source,{'other','unknown'},'Rare');

%Data cleaning for source_type
dataset.source_type = mergecats(dataset.source_type,{'other'},'Rare');

test.source_type = mergecats(test.source_type,{'other'},'Rare');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



end
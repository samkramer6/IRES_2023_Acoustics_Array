% Importing and normalizing test data
data = importdata('C:\Users\Nicholas Rock\Desktop\Brunei Research\6-23 Test\Test_Data_6_23_2023.mat'); 
data = data(2:end-1,:); time = data(:,1)*1000; data(:,1)=[];
ndata = normalize(data,"center","mean");

surf_plot(1,ndata)

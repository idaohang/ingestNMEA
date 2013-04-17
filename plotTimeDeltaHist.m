[ l12t, l12tm, l12u, v, w, T, err ] = ascii2mat_sonic('L12_1_20130411201358.dat');
[ l13t, l13tm, l13u, v, w, T, err ] = ascii2mat_sonic('L13_1_20130411201139.dat');
[ l13t, l13tm, l13u, v, w, T, err ] = ascii2mat_sonic('L14_1_20130411201421.dat');

l13_l12=(l13t-l12t(1:end-1))*86400;
l13_l14=(l13t-l14t)*86400;
l12_l14=(l12t(1:end-1)-l14t)*86400;
%tDiff=(l13t-l12t);

[h,x]=create_hist_20130401_JA(l13_l12,.00001);
plot(x,h);
xlim([-.001,.001]);
legend('Timestamp differences: l13 - l12');
xlabel('Seconds');
ylabel('Count');
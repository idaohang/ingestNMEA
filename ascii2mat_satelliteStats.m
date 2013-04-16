filename='NMEAtest.log';
%filename='L13satStatsBAO3.log';
%function [t,satellites,PRN,SNR] = ascii2mat_satelliteStats(filename)
    
    % Count lines in the file
    fid = fopen(filename,'rt');
    nLines = 0;
    while (fgets(fid) ~= -1),
        nLines = nLines+1;
    end
    fclose(fid);
    
    string = '';
    message = 1;
    %PRN = zeros(12,nLines/4);
    PRN = repmat({''},12,nLines/4);
    SNR = cell(12,nLines/4);
    %SNR{12,nLines/4} = [];
    %SNR = zeros(12,nLines/4);
    %SNR = repmat({''},12,nLines/4);
    ELE = zeros(12,nLines/4);
    AZM = zeros(12,nLines/4);
    satellites = zeros(1,nLines/4);
    rawDates = repmat({''},2,nLines/4);
    
    inFile = fopen(filename);
    
    while 1
        line = fgetl(inFile);
        if ~ischar(line), break, end
        
        % Read GPRMC sentence
        if regexp(line,'.+GPRMC.+')
            strings = strsplit(',',line);
            rawDates(1,message) = strings(2);
            rawDates(2,message) = strings(10);

            gpgsv = [];
            %gpgsvMessages=10;
            
            line = fgetl(inFile);
            strings = strsplit(',',line);
            gpgsvMessages = str2double(strings(2));
            satellites(message) = str2double(strings(4));
            lastValue = strings(end);
            strings{end} = lastValue{1}(1:2);
            gpgsv = [gpgsv,strings(5:end)];
            
            for i=1:gpgsvMessages-1,
                line = fgetl(inFile);
                strings = strsplit(',',line);
                gpgsvMessages = str2double(strings(2));
                satellites(message) = str2double(strings(4));
                lastValue = strings(end);
                strings{end} = lastValue{1}(1:2);
                gpgsv = [gpgsv,strings(5:end)];
            end
                
            
            % Begin reading GPGSV scentences
%             line = fgetl(inFile);
%             strings = strsplit(',',line);
%             satellites(message) = str2double(strings(4));
%             
%             lastValue = strings(end);
%             strings{end} = lastValue{1}(1:2);
%             gpgsv = strings(5:end);
%             
%             line = fgetl(inFile);
%             strings = strsplit(',',line);
%             lastValue = strings(end);
%             strings{end} = lastValue{1}(1:2);
%             gpgsv = [gpgsv,strings(5:end)];
%             
%             line = fgetl(inFile);
%             strings = strsplit(',',line);
%             lastValue = strings(end);
%             strings{end} = lastValue{1}(1:2);
%             gpgsv = [gpgsv,strings(5:end)];
        
            
            for i=1:satellites(message),
                PRN{i,message} = gpgsv{i*4-3};
                ELE(i,message) = str2double(gpgsv{i*4-2});
                AZM(i,message) = str2double(gpgsv{i*4-1});
                %SNR(i,message) = str2double(gpgsv{i*4});
                SNR{i,message} = str2double(gpgsv{i*4});
            end
            
        end
        
        message=message+1;
        %disp(line)
    end
    fclose(inFile);
    
    plot(mean(SNR));
    %plot(t_avg,tDiff1213_avg,'r',t_avg,tDiff1214_avg,'b');datetick('x',13);
%hold on
%plot(tNTP,offsetNTP,'b');
%xlabel('Time of recording (hh:mm:ss)');
%ylabel('Time (seconds)');
%ylim([0 14e-5]);
%legend('l12-l13','NTP offset');



%% RCNN_SymmetricGroups : Manual Labelling
%--------------------------------------------------------------------------
% 
% Function: This function fills the group structure with hard coded inputs.  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function [group] = fillGroupValues(group)
    %% CM
    group(1).Name    = 'CM';
    group(1).start_x =    1;
    group(1).start_y =    7;
    group(1).width   =   45;
    group(1).height  =   45;
    group(1).stride  =   45;

    %% CMM
    group(2).Name    = 'CMM';
    group(2).start_x =     1;
    group(2).start_y =    23;
    group(2).width   =    47;
    group(2).height  =    47;
    group(2).stride  =    47;

    %% P1
    group(3).Name    = 'P1';
    group(3).start_x =   11;
    group(3).start_y =    1;
    group(3).width   =   44;
    group(3).height  =   32;
    group(3).stride  =   32;

    %% P2
    group(4).Name    = 'P2';
    group(4).start_x =   11;
    group(4).start_y =    1;
    group(4).width   =   44;
    group(4).height  =   32;
    group(4).stride  =   32;

    %% P4
    group(5).Name    = 'P4';
    group(5).start_x =   16;
    group(5).start_y =   16;
    group(5).width   =   32;
    group(5).height  =   32;
    group(5).stride  =   32;

    %% P4G
    group(6).Name    = 'P4G';
    group(6).start_x =    16;
    group(6).start_y =    16;
    group(6).width   =    32;
    group(6).height  =    32;
    group(6).stride  =    32;

    %% P4M
    group(7).Name    = 'P4M';
    group(7).start_x =    16;
    group(7).start_y =    16;
    group(7).width   =    32;
    group(7).height  =    32;
    group(7).stride  =    32;

    %% PG
    group(8).Name    = 'PG';
    group(8).start_x =    1;
    group(8).start_y =    1;
    group(8).width   =   32;
    group(8).height  =   32;
    group(8).stride  =   32;

    %% PGG
    group(9).Name    = 'PGG';
    group(9).start_x =     1;
    group(9).start_y =     1;
    group(9).width   =    32;
    group(9).height  =    32;
    group(9).stride  =    32;

    %% PM
    group(10).Name   = 'PM';
    group(10).start_x=    1;
    group(10).start_y=    1;
    group(10).width  =   32;
    group(10).height =   32;
    group(10).stride =   32;

    %% PMG
    group(11).Name   = 'PMG';
    group(11).start_x=     1;
    group(11).start_y=     9;
    group(11).width  =    32;
    group(11).height =    32;
    group(11).stride =    32;

    %% PMM
    group(12).Name   = 'PMM';
    group(12).start_x=     1;
    group(12).start_y=     1;
    group(12).width  =    32;
    group(12).height =    32;
    group(12).stride =    32;
    
    %% P3
    group(13).Name   =  'P3';
    group(13).start_x=     1;
    group(13).start_y=    16;
    group(13).width  =    35;
    group(13).height =    30;
    group(13).stride =    35;
    
    %% P31M
    group(14).Name   ='P31M';
    group(14).start_x=     1;
    group(14).start_y=    16;
    group(14).width  =    35;
    group(14).height =    30;
    group(14).stride =    35;
    
    %% P3M1
    group(15).Name   ='P3M1';
    group(15).start_x=     1;
    group(15).start_y=     6;
    group(15).width  =    35;
    group(15).height =    30;
    group(15).stride =    35;
end
%==========================================================================
%% End
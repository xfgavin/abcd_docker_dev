function mmps_engine(varargin)
  %mode:
  %1: ${command}('$proj');
  %2: parms = []; ${parms}; args=mmil_parms2args(parms); ${command}('$proj', args{:});
  %3: batchdir subdir
  %   isbatchdirjob = 1;
  if isempty(regexp(varargin{:},'isbatchdirjob'))
    if ~isempty(regexp(varargin{:},'mmil_parms2args'))
      cmd = regexprep(varargin{:},'.*args=mmil_parms2args\(parms\); (.*)\(.*','$1');
    elseif ~isempty(regexp(varargin{:},'try'))
      cmd = regexprep(varargin{:},'.*try, (.*)\(.*','$1');
    elseif ~isempty(regexp(varargin{:},'parms=\[\];'))
      cmd = regexprep(varargin{:},'.*(\s|;)(.*)\(.*','$2');
    else
      cmd = regexprep(varargin{:},'(^.*)\(.*','$1');
    end;
    if ~CheckFunction(cmd), error('Unknow command: %s', cmd); end;
    fprintf('Executing: $%s$\n',varargin{:});
    eval(varargin{:});
  else
    jobdir = regexprep(varargin{:},'isbatchdirjob = 1;','');
    scriptlist = sprintf('%s/batchdirs/%s/scriptlist.txt',getenv('HOME'),jobdir);

    if ~exist(scriptlist), error('job scriptlist %s does not exist.',scriptlist); end;

    jobscripts = textread(scriptlist,'%s','delimiter','\n','whitespace',''); 
    for scriptid=1:length(jobscripts)
      jobname = jobscripts{scriptid};
      if isempty(jobname), continue; end;
      if ~isempty(regexp(jobname,'^job_.*'))
        jobfile = sprintf('%s/batchdirs/%s/%s.m',getenv('HOME'),jobdir,jobname);
        if ~exist(jobfile), error('job file %s does not exist.',jobfile); end;
        cmdstring = textread(jobfile,'%s','delimiter','\n','whitespace',''); 
        for cmdid = 1:length(cmdstring)
          if isempty(cmdstring{cmdid}), continue; end;
          if ~isempty(regexp(cmdstring{cmdid}, '^[^\(]*\(.*'))
            cmd = regexprep(cmdstring{cmdid},'^([^\(]*)\(.*','$1');
            if ~CheckFunction(cmd), error('Unknow command'); end;
          end
        end
        cmdstring = sprintf('%s',cmdstring{:});
        cmdstring = regexprep(cmdstring,'\.\.\.','');
        cmdstring = regexprep(cmdstring,'\)','\);');
        cmdstring = regexprep(cmdstring,';;',';');
        cmdstring = regexprep(cmdstring,';exit','');
        fprintf('Executing: $%s$',cmdstring);
        eval(cmdstring);
      end
    end
  end
end

function isallowed = CheckFunction(myfunc)
  isallowed = ismember(myfunc,{'ABCD_Compile_Exams','ABCD_Compile_Exam',...
                               'ABCD_Import_Exams','abcd_import',...
                               'ABCD_Check_PC_Exams','abcd_pc',...
                               'MMIL_autoQC_Exams','MMIL_autoQC_Exam',...
                               'MMIL_Process_Exams','MMIL_Process_Exam',...
                               'MMIL_Update_VisitInfo',...
                               'MMIL_Analyze_DTI_Exams','MMIL_Analyze_DTI_Exam',...
                               'MMIL_Analyze_MRI_Exams','MMIL_Analyze_MRI_Exam',...
                               'ABCD_Analyze_taskBOLD_Exams','ABCD_Analyze_taskBOLD_Exam',...
                               'ABCD_Analyze_rsBOLD_Exams','ABCD_Analyze_rsBOLD_Exam',...
                               'MMIL_Analyze_RSI_Exams','MMIL_Analyze_RSI_Exam',...
                               'MMIL_Freesurfer_Recon_Exams','MMIL_Freesurfer_Recon_Exam',...
                               'MMIL_Get_FSReconStatus',...
                               'ABCD_Summarize_taskBOLD_Exams','ABCD_Summarize_rsBOLD_Exams','ABCD_Summarize_DTI_Exams',...
                               'ABCD_Summarize_RSI_Exams','ABCD_Summarize_MRI_Exams','ABCD_Summarize_MRI_info_Exams',...
                               'MMIL_Summarize_DTI_Analysis','MMIL_Summarize_RSI_Analysis','MMIL_Summarize_MRI_Analysis',...
                               'MMIL_Summarize_MRI_Info','ABCD_Summarize_rsBOLD_Analysis','ABCD_Summarize_taskBOLD_Analysis',...
                               'ABCD_Analyze_taskBehav_Exams','ABCD_Analyze_taskBehav_Exam','ABCD_Summarize_taskBehav_Analysis',...
                               'load'});
end

%macro printall(libname,worklib=work);
   %local num i;
   proc datasets library=&libname memtype=data nodetails;
      contents out=&worklib..temp1(keep=memname) data=_all_ noprint;
   run;
   data _null_;
      set &worklib..temp1 end=final;
      by memname notsorted;
      if last.memname;
      n+1;
      call symput('ds'||left(put(n,8.)),trim(memname));
      if final then call symput('num',put(n,8.));
   run;
   %do i=1 %to &num;
      proc print data=&libname..&&ds&i (obs=5) noobs;
         title "Data Set &libname..&&ds&i";
      run;
   %end;
%mend printall;

%printall(DYDR5001)
%printall(DYDR5002)
%printall(DYDR5003)
%printall(DYDR5004)	
%printall(S1023115)

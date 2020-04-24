/******************************************************************************

	Handling Critical error's under Pharlap

  The PDC Prolog library that works together with the Pharlap DOS extender
  converts automatically protection violations to a Prolog exit.

  This is OK for the final program, but for debugging purposes it is better
  to be able to catch protection violations with the debugger.

  By defining two predicates as shown in this example is is possible to
  override the default handling in the library.

 อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
  Date Modified,บ By,  บ  Comments.
 อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
                บ      บ
******************************************************************************/


GLOBAL PREDICATES
  ERR_InstallCrit() - language c
  % Normal code are:
  % void DLP ERR_InstallCrit(void)
  % {
  %   DosSetPassToProtVec(0x24,critical_error,&old_crit_err_prot,&old_crit_err_real);
  %   DosSetExceptionHandler(0x0D,gpfault_handler,&old_gpfault);
  %   DosSetExceptionHandler(0x0,divzero_handler,&old_divzero);
  % }


  ERR_DeInstallCrit() - language c
  % Normal code are:
  % void DLP ERR_DeInstallCrit(void)
  % {
  %   DosSetRealProtVec(0x24,old_crit_err_prot,old_crit_err_real,0,0);
  %   DosSetExceptionHandler(0x0D,old_gpfault,NULL);
  %   DosSetExceptionHandler(0x0,old_divzero,NULL);
  % }


CLAUSES
  ERR_InstallCrit().
  ERR_DeInstallCrit().


/******************************************************************************
	Test the behaviour
******************************************************************************/

DOMAINS
  DOM = f(INTEGER)

GOAL
	TERM = cast(DOM,0),
	TERM = f(X),
	write(X).     % This should give a protection violation

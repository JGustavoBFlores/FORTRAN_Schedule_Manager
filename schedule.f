      PROGRAM SCHEDULER
      CHARACTER*1 ANS
      CHARACTER*6 SCH(6,5)
      DIMENSION TIME(6)

C OPEN THE RAW SCHEDULE FILE
      OPEN(UNIT=90,FILE='SCHEDULE',STATUS='OLD')

C READ THE ENTRIES FROM THE FILE
      DO I=1,6
      READ(90,10) TIME(I),(SCH(I,J),J=1,5)
      DO J=1,5
       IF(SCH(I,J).EQ.'      ')SCH(I,J)='******'
      END DO
      END DO

C PRINT THE SCHEDULE TO SCREEN WITH A FORMAT
      print 1, 
      print 2,
      DO I=1,6 
      print 3, 
      print 4, TIME(I),(SCH(I,J),J=1,5)
      END DO

C ASK WHAT THE USER WANTS TO DO
 1001 CONTINUE
      PRINT*, 'Do you want to change your schedule?(Y/N)'
C     READ*, ANS
      ANS='Y'
      IF(ANS.EQ.'N'.OR.ANS.EQ.'n')THEN
       PRINT*, 'Have a nice day!'
      ELSE IF(ANS.EQ.'Y'.OR.ANS.EQ.'y')THEN
       GO TO 1010
      ELSE 
       PRINT*, 'Thats not a Y or an N!'
       GO TO 1001
      END IF
 1010 CONTINUE
      PRINT*, "What time do you have right now? (Day's letter and time)"
      PRINT*, "                                  (example: M 9)"
      READ*, ANS,iTME  
      
      IF(ANS.EQ.'M'.OR.ANS.EQ.'m')THEN
       i=1
      ELSE IF(ANS.EQ.'T'.OR.ANS.EQ.'t')THEN
       i=2
      ELSE IF(ANS.EQ.'W'.OR.ANS.EQ.'w')THEN
       i=3
      ELSE IF(ANS.EQ.'H'.OR.ANS.EQ.'h')THEN
       i=4
      ELSE IF(ANS.EQ.'F'.OR.ANS.EQ.'f')THEN
       i=5
      ELSE 
       PRINT*, 'Not a valid day letter!'
       GO TO 1010
      END IF

      IF(iTIME.EQ.9





      stop
C
CC FORMATS:
C

 1    FORMAT(' _______ ________ ________ ________ ________ ________ ')
 2    FORMAT('|  TIME | MON(M) | TUE(T) | WED(W) | THU(H) | FRI(F) |')
 3    FORMAT('|-------|--------|--------|--------|--------|--------|')
 4    FORMAT('| ',A5,' | ',5(A6,' | '))

 10   FORMAT(A5,X,5(A6,X))
      end program

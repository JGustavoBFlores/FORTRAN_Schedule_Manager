      PROGRAM SCHEDULER
      PARAMETER(itotalH=6)
      CHARACTER*1 ANS
      CHARACTER*6 SCH(itotalH,5)
      DIMENSION iTIME(itotalH)

C PULL THE MOST RECENT VERSION 
      CALL SYSTEM("git pull --all")


C OPEN THE RAW SCHEDULE FILE
      OPEN(UNIT=90,FILE='SCHEDULE',STATUS='OLD')

C READ THE ENTRIES FROM THE FILE
      DO I=1,itotalH
      READ(90,10) iTIME(I),(SCH(I,J),J=1,5)
      DO J=1,5
       IF(SCH(I,J).EQ.'      ')SCH(I,J)='******'
      END DO
      END DO
C PRINT THE SCHEDULE TO SCREEN WITH A FORMAT
      PRINT 1, 
      PRINT 2,
      DO I=1,itotalH
      PRINT 3, 
      PRINT 4, iTIME(I),(SCH(I,J),J=1,5)
      END DO
      PRINT 3,
C ASK WHAT THE USER WANTS TO DO
 1001 CONTINUE
      PRINT*, 'Do you want to change your schedule?(Y/N)'
C     READ*, ANS(1)
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

C ASK 
      PRINT*, "What time do you have right now? (Day's letter and time)"
      PRINT*, "                                  (example: M 9)"
      READ*, ANS,iANS 
      
      IF(ANS.EQ.'M'.OR.ANS.EQ.'m')THEN
       Ji=1
      ELSE IF(ANS.EQ.'T'.OR.ANS.EQ.'t')THEN
       Ji=2
      ELSE IF(ANS.EQ.'W'.OR.ANS.EQ.'w')THEN
       Ji=3
      ELSE IF(ANS.EQ.'H'.OR.ANS.EQ.'h')THEN
       Ji=4
      ELSE IF(ANS.EQ.'F'.OR.ANS.EQ.'f')THEN
       Ji=5
      ELSE 
       PRINT*, 'Not a valid day letter!'
       GO TO 1010
      END IF

      DO I=1,itotalH
       IF(iANS.EQ.iTIME(I))GO TO 2020
      END DO
       PRINT*, 'Not a valid time!'
       GO TO 1010

 2020 CONTINUE
      IF(iANS.LE.12.AND.iANS.GE.iTIME(1))THEN
       ii=iANS-iTIME(1)+1
      ELSE
       ii=iANS+(12-iTIME(1)+1)
      END IF

      PRINT*,   ii,Ji
      IF(SCH(ii,Ji).eq.'******')THEN
       PRINT*, 'Pick a time with your name in it!' 
       GO TO 1010
      END IF

      PRINT*, 'Hello, ',SCH(ii,ji),'!'
1011  CONTINUE
      PRINT*, "What time do you want? (Day's letter and time)"
      PRINT*, "                                (example: M 9)"
      READ*, ANS,iANS 
      
      IF(ANS.EQ.'M'.OR.ANS.EQ.'m')THEN
       Jt=1
      ELSE IF(ANS.EQ.'T'.OR.ANS.EQ.'t')THEN
       Jt=2
      ELSE IF(ANS.EQ.'W'.OR.ANS.EQ.'w')THEN
       Jt=3
      ELSE IF(ANS.EQ.'H'.OR.ANS.EQ.'h')THEN
       Jt=4
      ELSE IF(ANS.EQ.'F'.OR.ANS.EQ.'f')THEN
       Jt=5
      ELSE 
       PRINT*, 'Not a valid day letter!'
       GO TO 1010
      END IF

      DO I=1,itotalH
       IF(iANS.EQ.iTIME(I))GO TO 2021
      END DO
       PRINT*, 'Not a valid time!'
       GO TO 1011

 2021 CONTINUE
      IF(iANS.LE.12.AND.iANS.GE.iTIME(1))THEN
       it=iANS-iTIME(1)+1
      ELSE
       it=iANS+(12-iTIME(1)+1)
      END IF

      PRINT*,   it,Jt
      IF(SCH(it,jt).NE.'******')THEN
       PRINT*, 'That time is taken! Pick an empty one!' 
       GO TO 1011
      END IF


      print*,SCH(ii,ji),SCH(it,jt)
      SCH(it,jt)=SCH(ii,ji)
      SCH(ii,ji)='******'
      
      
C PRINT THE FINAL SCHEDULE
      PRINT 1, 
      PRINT 2,
      DO I=1,itotalH
      PRINT 3, 
      PRINT 4, iTIME(I),(SCH(I,J),J=1,5)
      END DO
      PRINT 3,

C Edit the raw file:

      REWIND(90)
      DO I=1,itotalH
       WRITE(90,10) itime(I),(SCH(I,J),J=1,5)
      END DO

      OPEN(UNIT=80,FILE='README.MD')
      REWIND(80)
      WRITE(80,2)
      WRITE(80,21)
      DO I=1,itotalH
       WRITE(80,4) itime(I), (SCH(I,J),J=1,5)
      END DO

      CALL SYSTEM('git add --all')
      CALL SYSTEM("git commit -m 'commit'")
      CALL SYSTEM("git push --all")


      stop
C
CC FORMATS:
C

 1    FORMAT(' _______ ________ ________ ________ ________ ________ ')
 2    FORMAT('|  TIME | MON(M) | TUE(T) | WED(W) | THU(H) | FRI(F) |')
 3    FORMAT('|-------|--------|--------|--------|--------|--------|')
 4    FORMAT('| ',I2,':00',' | ',5(A6,' | '))

 10   FORMAT(I2,X,5(A6,X))
 21   FORMAT('| :---: | :---: | :---: | :---: | :---: | :---: |')
      end program

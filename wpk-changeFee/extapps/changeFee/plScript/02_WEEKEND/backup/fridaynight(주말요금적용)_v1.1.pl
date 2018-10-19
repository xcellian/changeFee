#!/usr/bin/perl
#	금요일밤에 실행할 요금변경 및 할인권 사용여부 변경 프로그램
#	주말 요금 설정을 위한 프로그램
#	Developer		: Julian(김준남)
#	개발날짜			: 2017년 7월 17일
#	<관련정보>
#	CPK_Payment		: 요금변경 관련 테이블
#						  
#	CCP_CouponInfo	: 할인권 사용여부 관련 테이블
#					  UPDATE CCP_CouponInfo SET use_yn = 'N' WHERE cpn_kind_cd = ''
#	CCP_ManualDcKey	: 할인키 관련 테이블(여기서는 사용하지 않음, 잘못 알고 넣은 내용임)

use DBI;
use strict;

my $timestamp;
$timestamp = substr(getLoggingTime(),0,8);

open(RESULT, ">>log/fridaynight_result_$timestamp.log") || die "can't create fridaynight_result.log\n";

my $server1 = "192.168.100.102";
my $db1 = "DRPKDB";
my $uid1 = "sa";
my $pwd1 = "\$pkdb2009#";
my $cn1 = "DBI:ODBC:Driver={SQL Server};server=$server1; database=$db1; uid=$uid1; pwd=$pwd1";

my $server2 = "192.168.100.105";
my $db2 = "DRPKDB";
my $uid2 = "sa";
my $pwd2 = "\$pkdb2009#";
my $cn2 = "DBI:ODBC:Driver={SQL Server};server=$server2; database=$db2; uid=$uid2; pwd=$pwd2";

$db1 = DBI->connect($cn1) or die "$DBI::errstr";
$db2 = DBI->connect($cn2) or die "$DBI::errstr";

########################################################################################################################################################
## DR Server 1 ##
# my $cmd1 = $db1->prepare("exec cr2_p_rptoutcarlist '$var1','$var2','$var3','$var4','','','','$var5',''");

#$cmd1->execute() or die "Couldn't execute statement: " . $cmd1->errstr;
#binmode STDOUT, ':encoding(euc-kr)';

#$cmd1->finish();

## P18 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 3000, earlybird_max_fee = 3000, reg_dtm = GETDATE()
						  where parkmaster_cd = '17'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P18 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P18 is finished\n";

$cmd1->finish();

## P45 요금 설정 ################################

#my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 7000, earlybird_max_fee = 7000, reg_dtm = GETDATE()
#						  where parkmaster_cd = '21'
#						  and park_zone_cd = '1'
#						  and use_yn = 'Y'
#						  and car_type_cd = 'PK0302'");
#
#$cmd1->execute() or die "Couldn't execute P45 statement: " . $cmd1->errstr;;
#$timestamp = getLoggingTime();
#print RESULT "$timestamp : P45 is finished\n";
#
#$cmd1->finish();

## P63 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 7000, earlybird_max_fee = 7000, reg_dtm = GETDATE()
						  where parkmaster_cd = '02'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P63 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P63 is finished\n";

$cmd1->finish();

## P65 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 8000, earlybird_max_fee = 8000, reg_dtm = GETDATE()
						  where parkmaster_cd = '01'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P65 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P65 is finished\n";

$cmd1->finish();

## P69 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 8000, earlybird_max_fee = 8000, reg_dtm = GETDATE()
						  where parkmaster_cd = '08'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P69 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P69 is finished\n";

$cmd1->finish();

## P79 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 7000, earlybird_max_fee = 7000, reg_dtm = GETDATE()
						  where parkmaster_cd = '03'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P79 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P79 is finished\n";

$cmd1->finish();

## P98 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 8000, earlybird_max_fee = 8000, reg_dtm = GETDATE()
						  where parkmaster_cd = '15'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P98 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P98 is finished\n";

$cmd1->finish();

## P106 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 5000, earlybird_max_fee = 5000, reg_dtm = GETDATE()
						  where parkmaster_cd = '23'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P106 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P106 is finished\n";

$cmd1->finish();

## P109 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 7000, earlybird_max_fee = 7000, reg_dtm = GETDATE()
						  where parkmaster_cd = '22'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P109 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P109 is finished\n";

$cmd1->finish();

## P112 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 5000, earlybird_max_fee = 5000, reg_dtm = GETDATE()
						  where parkmaster_cd = '27'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P112 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P112 is finished\n";

$cmd1->finish();

## P113 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 10000, earlybird_max_fee = 10000, reg_dtm = GETDATE()
						  where parkmaster_cd = '29'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P113 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P113 is finished\n";

$cmd1->finish();

## P116 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 5000, earlybird_max_fee = 5000, reg_dtm = GETDATE()
						  where parkmaster_cd = '35'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P116 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P116 is finished\n";

$cmd1->finish();

## P117 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 5000, earlybird_max_fee = 5000, reg_dtm = GETDATE()
						  where parkmaster_cd = '32'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P117 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P117 is finished\n";

$cmd1->finish();


## P118 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 5000, earlybird_max_fee = 5000, reg_dtm = GETDATE()
						  where parkmaster_cd = '33'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P118 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P118 is finished\n";

$cmd1->finish();

## P122 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 5000, earlybird_max_fee = 5000, reg_dtm = GETDATE()
						  where parkmaster_cd = '38'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P122 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P122 is finished\n";

$cmd1->finish();

## P123 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 3000, earlybird_max_fee = 3000, reg_dtm = GETDATE()
						  where parkmaster_cd = '37'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P123 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P123 is finished\n";

$cmd1->finish();

## P126 요금 설정 ################################
#my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 3000, earlybird_max_fee = 3000, reg_dtm = GETDATE()
#						  where parkmaster_cd = '39'
#						  and park_zone_cd = '1'
#						  and use_yn = 'Y'
#						  and car_type_cd = 'PK0302'");
#
#$cmd1->execute() or die "Couldn't execute P126 statement: " . $cmd1->errstr;;
#$timestamp = getLoggingTime();
#print RESULT "$timestamp : P126 is finished\n";
#
#$cmd1->finish();


## 할인권 사용여부 변경 ##
## Y -> N ################################
my $cmd1 = $db1->prepare("update CCP_CouponInfo set use_yn = 'N', reg_dtm = GETDATE()
						  where cpn_kind_cd in ('1801','0321','2001')");

$cmd1->execute() or die "Couldn't execute statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : Darae DB1 (1801,0321,2001)(Y->N) is finished\n";

$cmd1->finish();

## N -> Y ################################
my $cmd1 = $db1->prepare("update CCP_CouponInfo set use_yn = 'Y', reg_dtm = GETDATE()
						  where cpn_kind_cd in ('1802','1803','1804','1903','1007','0105','0320','0707','0710','2313','2209','3205')");

$cmd1->execute() or die "Couldn't execute statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : Darae DB1 (1802,1803,1804,1903,1007,0105,0320,0707,0710,2313,2209,3205)(N->Y) is finished\n";

$cmd1->finish();



$db1->disconnect();
$timestamp = getLoggingTime();
print RESULT "$timestamp : DR server1 is finished\n";

########################################################################################################################################################
## DR Server 2 ##

## P129 요금 설정 ################################
## 일요일만 적용하므로 주말 전체대상에서는 제외 ###############
#my $cmd1 = $db2->prepare("update CPK_Payment set day_max_fee = 5000, earlybird_max_fee = 5000, reg_dtm = GETDATE()
#						  where parkmaster_cd = '42'
#						  and park_zone_cd = '1'
#						  and use_yn = 'Y'
#						  and car_type_cd = 'PK0302'");

#$cmd1->execute() or die "Couldn't execute P129 statement: " . $cmd1->errstr;;
#$timestamp = getLoggingTime();
#print RESULT "$timestamp : P129 is finished\n";

#$cmd1->finish();

## P130 요금 설정 ################################
my $cmd1 = $db2->prepare("update CPK_Payment set day_max_fee = 6000, earlybird_max_fee = 6000, reg_dtm = GETDATE()
						  where parkmaster_cd = '44'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P130 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P130 is finished\n";

$cmd1->finish();

## P133 요금 설정 ################################
my $cmd1 = $db2->prepare("update CPK_Payment set day_max_fee = 5000, earlybird_max_fee = 5000, reg_dtm = GETDATE()
						  where parkmaster_cd = '46'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P133 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P133 is finished\n";

$cmd1->finish();

## 할인권 사용여부 변경 ##
## Y -> N ################################
my $cmd1 = $db2->prepare("update CCP_CouponInfo set use_yn = 'N', reg_dtm = GETDATE()
						  where cpn_kind_cd in ('4308')");

$cmd1->execute() or die "Couldn't execute statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : Darae DB2 (Y->N) is finished\n";

$cmd1->finish();


$db2->disconnect();

$timestamp = getLoggingTime();
print RESULT "$timestamp : DR server2 is finished\n";
print RESULT "$timestamp : -----------------------------------------------\n";

sub getLoggingTime {

    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
    my $nice_timestamp = sprintf ( "%04d%02d%02d %02d:%02d:%02d",
                                   $year+1900,$mon+1,$mday,$hour,$min,$sec);
    return $nice_timestamp;
}
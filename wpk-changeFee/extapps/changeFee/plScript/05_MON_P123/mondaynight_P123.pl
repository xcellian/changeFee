#!/usr/bin/perl
#	월요일밤에 실행할 요금변경 및 할인권 사용여부 변경 프로그램
#	평일 요금 설정을 위한 프로그램
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

open(RESULT, ">>C:/logs/changeFee/plLogs/05_MON_P123/mondaynight_result_$timestamp.log") || die "can't create mondaynight_result.log\n";

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
#$db2 = DBI->connect($cn2) or die "$DBI::errstr";

########################################################################################################################################################
## DR Server 1 ##
# my $cmd1 = $db1->prepare("exec cr2_p_rptoutcarlist '$var1','$var2','$var3','$var4','','','','$var5',''");

#$cmd1->execute() or die "Couldn't execute statement: " . $cmd1->errstr;
#binmode STDOUT, ':encoding(euc-kr)';

#$cmd1->finish();

## P123 요금 설정 ################################
my $cmd1 = $db1->prepare("update CPK_Payment set day_max_fee = 15000, earlybird_max_fee = 15000, reg_dtm = GETDATE()
						  where parkmaster_cd = '37'
						  and park_zone_cd = '1'
						  and use_yn = 'Y'
						  and car_type_cd = 'PK0302'");

$cmd1->execute() or die "Couldn't execute P123 statement: " . $cmd1->errstr;;
$timestamp = getLoggingTime();
print RESULT "$timestamp : P123 is finished\n";

$cmd1->finish();


$db1->disconnect();
$timestamp = getLoggingTime();
print RESULT "$timestamp : DR server1 is finished\n";

########################################################################################################################################################
## DR Server 2 ##


print RESULT "$timestamp : -----------------------------------------------\n";

sub getLoggingTime {

    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
    my $nice_timestamp = sprintf ( "%04d%02d%02d %02d:%02d:%02d",
                                   $year+1900,$mon+1,$mday,$hour,$min,$sec);
    return $nice_timestamp;
}
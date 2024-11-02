USE master;
GO

ALTER DATABASE BDIX    --KrystalosHSJM
ADD LOG FILE
(

    NAME = t1,
    FILENAME = 'c:\dbases\data\bdix_log2.ldf',
    SIZE = 1GB,
    FILEGROWTH = 100MB

)
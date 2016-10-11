USE AdventureWorks;
GO

CREATE TABLE #TestSeqID
(
  [ID] uniqueidentifier DEFAULT NEWSEQUENTIALID() PRIMARY KEY NOT NULL,
  Num int NOT NULL
);

INSERT INTO #TestSeqID 
(
  Num
)
VALUES
  (1),
  (2),
  (3);

SELECT
  [ID],
  Num
FROM #TestSeqID;

DROP TABLE #TestSeqID;
GO

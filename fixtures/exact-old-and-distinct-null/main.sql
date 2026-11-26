BEGIN TRANSACTION;
CREATE TABLE "closed_totals" (month TEXT PRIMARY KEY, issued_seconds INTEGER, through INTEGER);
CREATE TABLE "legacy_meter" (id TEXT PRIMARY KEY, month TEXT, units INTEGER, notes TEXT, rev INTEGER);
INSERT INTO "legacy_meter" VALUES('exact','05',2,'旧备注',1);
CREATE TABLE "modern_meter" (id TEXT PRIMARY KEY, month TEXT, seconds INTEGER, items TEXT, notes TEXT, rev INTEGER);
COMMIT;

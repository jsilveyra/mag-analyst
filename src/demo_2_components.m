parser = Parser('.\data\sampleData\Finemet - TA.csv', "H [A/m]", "B [T]", "Hysteretic loop");
[H, M, H_raw, M_raw] = parser.import();

data_curve = DataAnhystereticCurve(H, M);
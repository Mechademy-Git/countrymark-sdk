SELECT tagName AS sensor_id, timestamp, value
FROM ctc_config.dbo.ctc_fn_PARCdata_ReadRawTags(
    'CMC.Foxia.100_E21:TI195.PNT,
    CMC.Foxia.100_H1:FI126.PNT,
    CMC.Foxia.100_H1:FI80A.PNT,
    CMC.Foxia.100_H1:FI82A.PNT,
    CMC.Foxia.100_H1:TC83.MEAS,
    CMC.Foxia.100_H1:TI186.PNT,
    CMC.Foxia.100_H1:TI91A.PNT,
    CMC.Foxia.100_H1:TI91B.PNT,
    CMC.Foxia.100_R1B:FC38A.MEAS,
    CMC.Foxia.100_R1B:FI42.PNT,
    CMC.Foxia.100_R1B:II37.PNT,
    CMC.Foxia.100_V1:FC111.MEAS,
    CMC.Foxia.100_V1:FC25.MEAS,
    CMC.Foxia.100_V1:FC9.MEAS,
    CMC.Foxia.100_V1:FI25B.PNT,
    CMC.Foxia.100_V10:FC118.MEAS,
    CMC.Foxia.100_V10:FC185.MEAS,
    CMC.Foxia.100_V10:TI120.PNT,
    CMC.Foxia.100_V10:TI121.PNT,
    CMC.Foxia.100_V10:TI122.PNT,
    CMC.Foxia.100_V10:TI124.PNT,
    CMC.Foxia.100_V11:FC129.MEAS,
    CMC.Foxia.100_V11:LC153.MEAS,
    CMC.Foxia.100_V12:FC147.MEAS,
    CMC.Foxia.100_V12:FC154.MEAS,
    CMC.Foxia.100_V12:FC158.MEAS,
    CMC.Foxia.100_V12:FI140.PNT,
    CMC.Foxia.100_V12:FI157.PNT,
    CMC.Foxia.100_V12:FX157.PNT,
    CMC.Foxia.100_V12:LC151.MEAS,
    CMC.Foxia.100_V12:PC165.MEAS,
    CMC.Foxia.100_V12:PI152.PNT,
    CMC.Foxia.100_V12:TC141.MEAS,
    CMC.Foxia.100_V12:TC156.MEAS,
    CMC.Foxia.100_V12:TI131.PNT,
    CMC.Foxia.100_V12:TI138.PNT,
    CMC.Foxia.100_V12:TI140.PNT,
    CMC.Foxia.100_V14:TI115.PNT,
    CMC.Foxia.100_V14:TI116.PNT,
    CMC.Foxia.100_V15:LC44.MEAS,
    CMC.Foxia.100_V2:FC41.MEAS,
    CMC.Foxia.100_V2:PC24.MEAS,
    CMC.Foxia.100_V2:RFX41.PNT,
    CMC.Foxia.100_V2:TI12.PNT,
    CMC.Foxia.100_V20:PI160.PNT,
    CMC.Foxia.100_V6:FC36.MEAS,
    CMC.Foxia.100_V6:FC63.MEAS,
    CMC.Foxia.100_V6:TI610.PNT,
    CMC.Foxia.100_V6:TI626.PNT,
    CMC.Foxia.100_V6:TI68.PNT,
    CMC.Foxia.100_V6:TI74.PNT,
    CMC.Foxia.100_V6:TI76.PNT,
    CMC.Foxia.100_V6:TI77.PNT,
    CMC.Foxia.100_V6:TI81.PNT,
    CMC.Foxia.100_V6:TI82.PNT,
    CMC.Foxia.100_V7:PC108.MEAS,
    CMC.Foxia.100_V8:FC100.MEAS,
    CMC.Foxia.100_V8:FI100.PNT,
    CMC.Foxia.100_V8S:TI_099.PNT,
    CMC.Foxia.100_V8S:TI_109.PNT,
    CMC.Foxia.700_CT3:AI12.PNT,
    CMC.Foxia.700_CT3:PI56.PNT,
    CMC.Foxia.700_CT3:TC37.OUT,
    CMC.Foxia.700_CT3:TI37.PNT,
    CMC.Foxia.700_V115:AI209.PNT,
    CMC.Foxia.700_V115:AI210.PNT,
    CMC.Foxia.800_V30:FI441.PNT,
    CMC.Foxia.DCS:ABITEMP.PNT',
    :start_time, 
    :end_time,
    1, 
    ','
) AS ctc_fn_PARCdata_ReadRawTags_1
WHERE quality = 192

WDF{PROP:SQL} = 'SELECT GETDATE()'
ACCESS:WDF.NEXT()
CASE THISWINDOW.REQUEST
OF INSERTRECORD
   CLEAR(USLOG:RECORD)
   USLOG:CNSLOG     = clip(glo:idsede)&format(FnGeneraconsecutivo(glo:idsede,'@LOG'),@n08)
   USLOG:COMPANIA   = GLO:COMPANIA
   USLOG:NOADMISION = HADM:NOADMISION
   USLOG:PROCESO    = 'PREST.DETALLE(HPRED)'
   USLOG:REQUEST    = 'INSERT'
   USLOG:REFERENCIA = 'No. Prestación:'&CLIP(HPRED:NOPRESTACION)&' / '&CLIP(HPRED:NOITEM)
   !stop(len(USLOG:REFERENCIA))
   USLOG:USUARIO    = GLO:USUARIO
   USLOG:FECHA_DATE = WDF:C1_DATE
   USLOG:FECHA_TIME = WDF:C1_TIME
   USLOG:SYS_ComputerName = GLO:SYS_ComputerName
   ACCESS:USLOG.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 1
   USLOGH:CAMPO    = 'IDSERVICIO'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:IDSERVICIO
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 2
   USLOGH:CAMPO    = 'HPRED:CANTIDAD'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:CANTIDAD
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 3
   USLOGH:CAMPO    = 'HPRED:VALOR'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:VALOR
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 4
   USLOGH:CAMPO    = 'HPRED:VALORCOPAGO'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:VALORCOPAGO
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 5
   USLOGH:CAMPO    = 'HPRED:VALOREXCEDENTE'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:VALOREXCEDENTE
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 6
   USLOGH:CAMPO    = 'HPRED:IDPROVEEDOR'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:IDPROVEEDOR
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 7
   USLOGH:CAMPO    = 'HPRED:IDCONCEPTORIPS'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:IDCONCEPTORIPS
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 8
   USLOGH:CAMPO    = 'HPRED:AMBITO'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:AMBITO
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 9
   USLOGH:CAMPO    = 'HPRED:FINALIDAD'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:FINALIDAD
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 10
   USLOGH:CAMPO    = 'HPRED:PERSONAL_AT'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:PERSONAL_AT
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 11
   USLOGH:CAMPO    = 'HPRED:FORMAQX'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:FORMAQX
   ACCESS:USLOGH.INSERT()
   CLEAR(USLOGH:RECORD)
   USLOGH:CNSLOG   = USLOG:CNSLOG
   USLOGH:ITEM     = 12
   USLOGH:CAMPO    = 'HPRED:VALORPCOMP'
   USLOGH:VALORANT = ''
   USLOGH:VALORNVO = HPRED:VALORPCOMP
   ACCESS:USLOGH.INSERT()

OF CHANGERECORD
   CLEAR(USLOG:RECORD)
   USLOG:CNSLOG     = clip(glo:idsede)&format(FnGeneraconsecutivo(glo:idsede,'@LOG'),@n08)
   USLOG:COMPANIA   = GLO:COMPANIA
   USLOG:NOADMISION = HADM:NOADMISION
   USLOG:PROCESO    = 'PREST.DETALLE(HPRED)'
   USLOG:REQUEST    = 'CHANGE'
   USLOG:REFERENCIA = CLIP(HPRED:NOPRESTACION)&' /'&CLIP(HPRED:NOITEM)
   !stop(len(USLOG:REFERENCIA))
   USLOG:USUARIO    = GLO:USUARIO
   USLOG:FECHA_DATE = WDF:C1_DATE
   USLOG:FECHA_TIME = WDF:C1_TIME
   USLOG:SYS_ComputerName = GLO:SYS_ComputerName
   ACCESS:USLOG.INSERT()
   IF COPIA:HPRED:IDSERVICIO <> HPRED:IDSERVICIO
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 1
      USLOGH:CAMPO    = 'IDSERVICIO'
      USLOGH:VALORANT = COPIA:HPRED:IDSERVICIO
      USLOGH:VALORNVO = HPRED:IDSERVICIO
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:CANTIDAD <> HPRED:CANTIDAD
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 2
      USLOGH:CAMPO    = 'HPRED:CANTIDAD'
      USLOGH:VALORANT = COPIA:HPRED:CANTIDAD
      USLOGH:VALORNVO = HPRED:CANTIDAD
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:VALOR <> HPRED:VALOR
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 3
      USLOGH:CAMPO    = 'HPRED:VALOR'
      USLOGH:VALORANT = COPIA:HPRED:VALOR
      USLOGH:VALORNVO = HPRED:VALOR
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:VALORCOPAGO = HPRED:VALORCOPAGO
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 4
      USLOGH:CAMPO    = 'HPRED:VALORCOPAGO'
      USLOGH:VALORANT = COPIA:HPRED:VALORCOPAGO
      USLOGH:VALORNVO = HPRED:VALORCOPAGO
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:VALOREXCEDENTE <> HPRED:VALOREXCEDENTE
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 5
      USLOGH:CAMPO    = 'HPRED:VALOREXCEDENTE'
      USLOGH:VALORANT = COPIA:HPRED:VALOREXCEDENTE
      USLOGH:VALORNVO = HPRED:VALOREXCEDENTE
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:IDPROVEEDOR <> HPRED:IDPROVEEDOR
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 6
      USLOGH:CAMPO    = 'HPRED:IDPROVEEDOR'
      USLOGH:VALORANT = COPIA:HPRED:IDPROVEEDOR
      USLOGH:VALORNVO = HPRED:IDPROVEEDOR
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:IDCONCEPTORIPS <> HPRED:IDCONCEPTORIPS
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 7
      USLOGH:CAMPO    = 'HPRED:IDCONCEPTORIPS'
      USLOGH:VALORANT = COPIA:HPRED:IDCONCEPTORIPS
      USLOGH:VALORNVO = HPRED:IDCONCEPTORIPS
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:AMBITO <> HPRED:AMBITO
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 8
      USLOGH:CAMPO    = 'HPRED:AMBITO'
      USLOGH:VALORANT = COPIA:HPRED:AMBITO
      USLOGH:VALORNVO = HPRED:AMBITO
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:FINALIDAD <> HPRED:FINALIDAD
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 9
      USLOGH:CAMPO    = 'HPRED:FINALIDAD'
      USLOGH:VALORANT = COPIA:HPRED:FINALIDAD
      USLOGH:VALORNVO = HPRED:FINALIDAD
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:PERSONAL_AT <> HPRED:PERSONAL_AT
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 10
      USLOGH:CAMPO    = 'HPRED:PERSONAL_AT'
      USLOGH:VALORANT = COPIA:HPRED:PERSONAL_AT
      USLOGH:VALORNVO = HPRED:PERSONAL_AT
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:FORMAQX <> HPRED:FORMAQX
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 11
      USLOGH:CAMPO    = 'HPRED:FORMAQX'
      USLOGH:VALORANT = COPIA:HPRED:FORMAQX
      USLOGH:VALORNVO = HPRED:FORMAQX
      ACCESS:USLOGH.INSERT()
   END
   IF COPIA:HPRED:VALORPCOMP <> HPRED:VALORPCOMP
      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 12
      USLOGH:CAMPO    = 'HPRED:VALORPCOMP'
      USLOGH:VALORANT = COPIA:HPRED:VALORPCOMP
      USLOGH:VALORNVO = HPRED:VALORPCOMP
      ACCESS:USLOGH.INSERT()
   END
OF DELETERECORD
   CLEAR(USLOG:RECORD)
   USLOG:CNSLOG     = clip(glo:idsede)&format(FnGeneraconsecutivo(glo:idsede,'@LOG'),@n08)
   USLOG:COMPANIA   = GLO:COMPANIA
   USLOG:NOADMISION = HADM:NOADMISION
   USLOG:PROCESO    = 'PREST.DETALLE(HPRED)'
   USLOG:REQUEST    = 'DELETE'
   USLOG:REFERENCIA = CLIP(HPRED:NOPRESTACION)&'-ITEM:'&CLIP(HPRED:NOITEM)
   !stop(len(USLOG:REFERENCIA))
   USLOG:USUARIO    = GLO:USUARIO
   USLOG:FECHA_DATE = WDF:C1_DATE
   USLOG:FECHA_TIME = WDF:C1_TIME
   USLOG:SYS_ComputerName = GLO:SYS_ComputerName
   ACCESS:USLOG.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 1
      USLOGH:CAMPO    = 'IDSERVICIO'
      USLOGH:VALORANT = HPRED:IDSERVICIO
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 2
      USLOGH:CAMPO    = 'HPRED:CANTIDAD'
      USLOGH:VALORANT = HPRED:CANTIDAD
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 3
      USLOGH:CAMPO    = 'HPRED:VALOR'
      USLOGH:VALORANT = HPRED:VALOR
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 4
      USLOGH:CAMPO    = 'HPRED:VALORCOPAGO'
      USLOGH:VALORANT = HPRED:VALORCOPAGO
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 5
      USLOGH:CAMPO    = 'HPRED:VALOREXCEDENTE'
      USLOGH:VALORANT = HPRED:VALOREXCEDENTE
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 6
      USLOGH:CAMPO    = 'HPRED:IDPROVEEDOR'
      USLOGH:VALORANT = HPRED:IDPROVEEDOR
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 7
      USLOGH:CAMPO    = 'HPRED:IDCONCEPTORIPS'
      USLOGH:VALORANT = HPRED:IDCONCEPTORIPS
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 8
      USLOGH:CAMPO    = 'HPRED:AMBITO'
      USLOGH:VALORANT = HPRED:AMBITO
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 9
      USLOGH:CAMPO    = 'HPRED:FINALIDAD'
      USLOGH:VALORANT = HPRED:FINALIDAD
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 10
      USLOGH:CAMPO    = 'HPRED:PERSONAL_AT'
      USLOGH:VALORANT = HPRED:PERSONAL_AT
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 11
      USLOGH:CAMPO    = 'HPRED:FORMAQX'
      USLOGH:VALORANT = HPRED:FORMAQX
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

      CLEAR(USLOGH:RECORD)
      USLOGH:CNSLOG   = USLOG:CNSLOG
      USLOGH:ITEM     = 12
      USLOGH:CAMPO    = 'HPRED:VALORPCOMP'
      USLOGH:VALORANT = HPRED:VALORPCOMP
      USLOGH:VALORNVO = ''
      ACCESS:USLOGH.INSERT()

END

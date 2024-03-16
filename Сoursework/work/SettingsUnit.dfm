object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 562
  ClientWidth = 888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -33
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnResize = SettingsFormResize
  TextHeight = 45
  inline MenuFrame: TMenuFrame
    Left = 0
    Top = 0
    Width = 888
    Height = 562
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 882
    ExplicitHeight = 553
    inherited BackGroundImage: TImage
      Width = 888
      Height = 562
      ExplicitLeft = -40
      ExplicitTop = 432
      ExplicitWidth = 888
      ExplicitHeight = 562
    end
    inherited TitleLabel: TLabel
      Left = 216
      Top = 32
      ExplicitLeft = 216
      ExplicitTop = 32
    end
    inherited MediaPlayer: TMediaPlayer
      Left = 584
      Top = 488
      ExplicitLeft = 584
      ExplicitTop = 488
    end
  end
  object BackPanel: TPanel
    Left = 320
    Top = 347
    Width = 217
    Height = 47
    Cursor = crHandPoint
    Caption = #1053#1072#1079#1072#1076
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsItalic]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    OnClick = BackPanelClick
    OnMouseEnter = PanelMouseEnter
    OnMouseLeave = PanelMouseLeave
  end
  object VolumePanel: TPanel
    Left = 320
    Top = 160
    Width = 217
    Height = 161
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 2
    object VolumeImage: TImage
      Left = 41
      Top = 25
      Width = 127
      Height = 111
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000001680000
        013D080600000026A6F891000000017352474200AECE1CE90000000467414D41
        0000B18F0BFC61050000000970485973000012740000127401DE661F7800001D
        074944415478DAEDDD4DA865D59987F1ED30422277D04E126E57A2832A67499B
        A91532B4C1414C3062350E834DD33D0942215A94D2144826DD342D194A579114
        6A0601336C62A6960949401DC4682499D8834B13E8A95DEFDD77D539FBDC753E
        F77FEDFDAE773DBF81ADD5A4B81FE73E779F77AFB5F67D9F7FFEA7CF3BA00AC7
        A7FF7CE1EAD5EE3B4F3ED9FDDDA30FCEFD010145DD47A05187E3EEE4E4A47BF6
        992BDD3BBFFC65F7DFBF7A8740233C020DE7FAABE6F7EEDCE99EFAEEF7BAFFF9
        ECB3D3FF26D068018186638B91C67FFCDBBF9FFEFBDF3CF8E069A409345A40A0
        E1D470A461614E08345A41A0E1D2ADFFFA5577EDC5174F63BC1C6743A0D10A02
        0D775EB8FADA60A4B18A40A315041A6E9C9C7C313BD25845A0D10A020D17368D
        34561168B482406376DB461AAB08345A41A0319BF7EE7CD65D7FE9DAD691C62A
        028D561068CC629F91C62A028D5610684C6EDF91C62A028D5610684CC6461A69
        BBF621614E08345A41A031091B69FCE30F7E70FAEF63E26C08345A41A05184AD
        693E3AFAEB606DB3191B6743A0D10A028D62C6DC08DC8440A315041A458CBD11
        B80981462B0834A476DDAE3D06818E2DAD8F7FFFFDF7077FFED4D3DF3F7B92CE
        A3677FF2E9DC1F6A71041A32A5461AAB08744CCB1B974C3AFB3BFDDFE49FFEE5
        9FBB1F3EFF7C777474D4458F34818644C991C62A021D8FC5F9DB8F5D3EFDF75D
        CE62B9FCAD6F75AFDFBA193ED2041AA34C31D25845A063D927CE265D4DB71069
        028D834D35D25845A06379E2F1E70EFA05DFC2953481C641A61C69AC22D071A4
        ABE743B7FC9BC89126D0D88B6ABBF618043A8EF48B7EECD6FFA89126D0D89972
        BBF618043A8E872F5C96FCB24F91FEF92FDE3EFB93189126D0D8AAC476ED3108
        741CAA401BFB7B6C09DEBFDEB871F627F5479A4063230F238D55043A0E75A04D
        A4481368AC35E78DC04D08741C87AEE0D86478254DA011CCA18FA29A0A818E23
        DDD75007DAFCE78F7FDC3DF30F57BA9A234DA03130D7DAE67D10E838ECFEC637
        BFFE8D22271E9AFE7552EFD91D041AF7781D69AC22D0911CDFBD28B829BF8A36
        29FAB7DF7CE32CD2041A159A63BBF618043A9AE3BB17075747AF87CE49917EF7
        37BFAE728D34816E5C0D238D55043A9AE3D37F3EF1F8DF17B948A8798D34816E
        582D238D55043AA2F291AE71F91D816E90F7551ADB10E8A8CA45FAFC1A69020D
        87BC6CD71E83404756FE4ABAA6E57704BA21695380A935CE86404777DC9D9C9C
        14B9715DDBCA0E02DD008FDBB5C720D02D281BE95A4EBF23D0C1D57A23701302
        DD8A3ED2A536B2D4B0B283408754EEEAC30302DD92E3BBEF00EF14790758C33C
        9A4087D2DF60B19D59B5AD6DDE07816E4D1FE97D9E5BB88BF3DBC1FD459A4087
        D15F35FFE8D557C38D345611E836955881E47DA721810EA2F6B5CDFB20D0ED52
        3C226B95E77934810EA0C6EDDA6310E8B6958AB4C7793481AE5CC4551ADB10E8
        B69538DC6B38EAF8EBDC9FE23D04BA52B59D40A744A05B5766F9DD62D4F1DADC
        9FE03D04BA42AD8D34561168945A7EB73854E9B9B93FC15304BA322D8E345611
        68F4F487FD0F97DECDFFFA22D09588B65D7B0C028D05FD61FF9E461D04BA0211
        4EA05322D0582873FA9D97510781766BB85DDB10E71E81C6907E1EED65D441A0
        DD6963BBF618041AE7959947DBDFF5874FDE99EDB322D0AEF4714E3335439CCF
        23D0386FF8B31365D441A0DDE8DFA6B5B25D7B0C028DBC32A7382E5E6FD31FA8
        44A067C748635F041AEB959947CF755607819E553B27D02911686C56661E3DC7
        591D047A16FD5533238DC310686CA65F7A37D7B1A4047A728C34C622D0D84E7F
        5EC7E286E18D8E4087C4DA6605028D5DA54D5EB5AE8D26D0136AE950FD920834
        F6A13C3F7AEA6DE0047A226CD7D621D0D8871DCDAB1E75F4370C1F2BFEB113E8
        A218699440A0B12FF5A863AA1D8604BA086E049644A07188271E7F4EBAAA638A
        1D86045A8EEDDAA511E8DDD85BFB3F7EF451F7E1071F9EFEF7C54B17BBAF3DF4
        90AB473A4D497964EF548FC822D05265B69A6288406F6661B6CD4FB77FF2D37B
        2B0F96D94DAE6B2F5F3FDBBA6CFC3C24B534F50DC3D257D1045A8291C69408F4
        7ACB37A3CDEAEB7039D88B35BDA69D48AB461D532CBB23D0A3B15D7B6A043A6F
        9F9542292E2D46DA461DDF7EEC7215CBEE08F4C1D8AE3D17027D9E8D352E7CF9
        2BA7FFBEEBEBB0DD481FCBB781977A3D12E8832C461AAC6D9E1E813EEFD0B7ED
        6D465ABB0DBCE4553481DE1B238DB911E8A174F53CE675383C67C2C48FB4F270
        FF52AF4902BD279EAE3D3F023DA4DA8431C76140F3A9E32A9A40EFC17E1058A5
        313F023DA40CB499E3DCE3B9A87718AA5F97047A07695D29230D1F08F490726D
        AF99F3114F73502EBB535F4513E82D1869F843A08794578126BDD66FBFF94613
        5F63CF57D1047A8374656288B31F047A481D6833E581401E94B88AB677DE66CC
        56F0FBEEBCFB6EF581569F2F605F58B66BFB45A087D4C76926539F7D3C27F5E6
        953422B21B91A302FDA52FDC2F09B47D62E905B2CBFF55529FCD5AE28A043A04
        7A95FE21A9C954A7B679A0BC8A4EAB614607FAA1BFBD50F5157489C3B395BF4D
        A147A057E91F929A0C5776943FA07E4E8AF5E44679460781CE20D0BE11E89C72
        2729CEF12CBEB9E8AFA2C7BDF320D01904DA3702BD8E5D497F2A3D983E99EAFC
        E3B9A97FF6C77EBD08740681F68D406FF7F085CBDC343C90F22A7A6C9B087406
        81F68D406F737C7ACA6289F5FB533E30752EAA9F7FC52F34029D41A07D23D0BB
        2813E9E13C3AEE4E43E555F498D72A81CE20D0BE11E85DF591B6D7B25146DAAE
        0C5FBF75B33B3A3AEA22465A79153DE6662181CE20D0BE11E87D945923DDC2C9
        778A39FED89BAB043A8340FB46A0F7A53DFBD8B430EAD01FE3BAFF553481CE20
        D0BE11E87DF51B594A44BA3FAFE3E3B33F891769D555F4A1370B09740681F68D
        401FA2CC4696E8A30ED551AE87BE6609740681F68D401FAEC4F1B991BF1FCAED
        DF878C3908740681F62D7210A6A07E7DC7DEC0A27902F8A1370B09740681F68D
        408FA77C0A4BEC039574AB600E691581CE20D0BE11680DE5991D71CFEAE86FB0
        3E7CE1ABB3DC2C24D01904DA3702ADA13EE83FEED9D1BA658AF635FAE42F7FDE
        79830F81CE20D0BE11681DF5F3F84CBCEF4DBF02467BB370B7552F043A8340FB
        46A0953437C192C8370C1523A1C5D7E7ED8E401F8840FB46A095FAAB43F5A823
        E20D43E5BB8D7E56BF7DCC41A03308B46F045AADCC791DD19E08AE9AD92F9A75
        A523D00720D0BE11E812F4A38E8857D18AE589FB8C3908740681F68D409750E6
        FCE86857D1CA63487759CD41A03308B46F04BA14EDA823EA55B4EA00A55DC61C
        043A8340FB46A04BD28D3A16A7DDC5BA8A9E72CC41A03308B46F04BAA4C55358
        B88ACE53F661DBCE4B029D41A07D23D0E5299FC917F12A5A3BE658DF2E029D41
        A07D23D0E5297F06225E45ABC61CDBB6C613E80C02ED1B819E86F2B0FAB4BBD0
        D61247384C49B16965975D97043A8340FB46A0A7910EAB37731CB5E99972D34A
        BFDC2EFF4B8B40671068DF08F4744A5C45C7A03BC87F53BF08740681F68D404F
        4B71432C89735EB466CDF8B65F5C043A8340FB46A0A7A53A2428D679D1DAE588
        EB56B910E80C02ED1B819E9672DE1A6BC9DDB1EC492BEBE6D0043A8340FB3665
        A0EDB5F0B3B7DEEA7EFFDBDFDDFBB3A79E7EBABB78E96253BF2094B3E838BF5C
        354F5AD9D430029D41A07D9BE287DC5E03E9E0A0756C7678EDE5EB4162B399F2
        2A3ACECD42DD1C7ADDE88740671068DF4A073ACD5CCDBAD7400AB7FDFFAFBFF2
        CA4E67FBD64EF990D918370B170F3B1863D3E88740671068DF4A067A9738AF7E
        2C66D703D86BA63C6A33CE9A68DD72BBDC1C9A40671068DFCA047ADCA39FF679
        4A46CDB4CFE58B31E628398726D01904DAB752811EF38396A27EFBCD37EE7E5C
        8F765123AD5C72B769075D3D34CBEDD6CDA109740681F6AD54A0C72E996A21D2
        E966E158B1C61C5DF7C0FD978ABCAB20D01904DAB7128156CE57ED07EDF55B37
        035C1DE6690FAC8F30E6183FFA5977A39040671068DF3C073A7D7C91E2B34AF1
        B54A3757638C3974BFB4565FD7043A8340FBE63DD0E9638CF4167E48B7832ECA
        D74875FC68FA7AD828C910E80C02ED5B8940AB36622C7F8C26CEAEB965BA950B
        51DE69A4A35955370A09F40604DAB752EBA095A7B6A58F33D6D91389F6A0A07E
        D3CA5157FB4DD5B1AF9FD5071B18029D41A07D2B1568D57913AB1F6B9C13DC86
        546BA2A3AC1F57DD284CBFB06C5D3E81CE20D0BE950AB47ACC51FAE39D9BF6B9
        7C37BADA03ADBD51F828815E8740FB563278E97B6F94A38E28B3D665AAD51CFD
        D7E6EDAEF640AB6E1412E82D08B46F65AF4817F355C3AA8ECD1473FBC5AEC2BA
        E7D0AA1B8569E443A0D720D0BE951F192C8E9134AA551D8BF962FDEB7E13D5DB
        FA287368C58DC234F221D06B1068DFA699E96ACEFA5DFDB8A3DD3054BDAD8F32
        8756DC284C231F02BD0681F66DBA9B6E9AF5BECB1FB789B27BCEA8DED6479943
        8F7D47B1589AF931815E8740FB3665A08DE2BCDFE58F3DDA55B4E26D7D94F18F
        EAB4BFB4D48E40671068DFA65DB636EE9CE8DCC76E225D45973A87A246EA951C
        043A8340FB36C70FB3EACA287DFC91AEA2D5E750D44CB5F430DD3425D01904DA
        B7B9AEB654CFE48BB6055C7D0E45CDB45F8B1B043A8740FB3657A0953B0DA35C
        3126CA73286AA75C6A47A03308B46F73CE2B958F7C8A1224A33A97E37FFFEF83
        B93F95D9BF16CBAB5A08740681F66DEE1B4ACA5147841B634635878E70F39440
        AF7C3204BA2D73874D79151D61EE6AB437C7EA1EFBA84E45B4B5D0043A8340FB
        3677A08DEA2D7D949B85AA4047F88545A09710E8F67808B4F22A3AC2DB7AC50D
        D4287379E5B88740671068DF3C04DAA84E728BF0B6DE36F48CDD711925D0AA77
        13F61A27D01904DA372F8156EDA08B1025E5B925B58F7C08F4CA2742A0DBE225
        D08A4D0949FDE7508C0F74A499FC03F75F22D0E91321D06DF11268A3BA59E8E5
        F3399CE678D6283379C56615EB1A81CE20D0BE790A9AF6C0FA9AE7D09A277D7B
        FADE8E61811E23AD6821D01904DA374F3FC42C2F1B5284A9FE5F56BAEDDE043A
        8340FBE629D046751E72DDB3573B3BFB53D95B7B024DA0D722D0BE790BB46AEB
        77FD370A950705D5FD6E42B5DD9B40671068DFBC055A7B48BB8FCFE9508A3011
        E8DE238F3C42A07308B46FDE62C639140BBA8382EA5E17CE15F4D22742A0DBE2
        2DD046B1EE952BC73881569DC741A03308B46F1E03CD81F53DC553ADF93A2C10
        E80C02ED9BBF40730E45A20874FD2B5A08F43D04BA3D04DA2FDD519B16E87EE9
        5E8D54A71D12E80C02ED9BC740730E454F1BE87A11E83304BA3D11039DB41EA6
        E12F2AAEA009740681F6CD63A0C71E1414E50A5AB526BC7F782C8126D01904DA
        B788814E0834815E46A03308B46F1103CD15F410238E1E81CE20D0BE450C7442
        A0B9825E46A03308B46F1E03CD2A8E9E761D348126D01904DAB7A881661DF442
        EDBFA808F41902DD1E8F8166A34A8F2BE81E813E43A0DB43A0FDE20A5AFB7520
        D01904DA376F81B6A77B7FF3EBDFE0B0A48ED3EC12027D8640B7C763A02F7CF9
        2B1C37DA11E84475AA1F81CE20D0BE790B3407F62F1068CDD7C1F044953508B4
        6FDE02CD23AF1678E495EEEBC015F41A04DA376F31535C2DD9E7F4C95FFECC43
        6309F4BDAF03815E8340FBE62DD063A394D4BE72217D2DC68832EA51FDA222D0
        1904DA374F8156CD9FEBBF6A3CEE4E4E4E24AB59083481DE8840FBE629D08AE5
        5431A2747CF7E7E68EE4979597EFED188A7712047A0D02ED9BA71F62D5FCD9CB
        E77338CD8151F5CFE2FBDD8F8A2B68EB1A81CE20D0BE79099A6ABC61FFFB777F
        F3EB8AA36438306AD903F75F92FCD226D01904DA372F81568D3722ACFB25D00B
        AA5FDC047A0D02ED9B97402B566FC4983F1BCE234908F4CA2742A0DBE221D0AA
        D3CAEA9FB9F6388F6441B571C95E17043A8340FBE621D0AA9B8311DED21B961B
        2EE84EF4FB9840E71068DFE60EB4F2EA3942900CE7912CA80E4AFAF92FDE26D0
        3904DAB7B903ADB87AF6F0792829DFD6D73EEED11D1845A0B308B46F73864DF5
        F635CABC355144C9106802BD1581F66D9E406BB6322F7F0E11DECE278A8D1929
        4AB53EE64AF9B5E8475F3708740E81F66DAE408F5D46B6FCF147B93968B40F2C
        B8D1D51C68F5D78240671068DFA60FB4661BF3F2C71FE5E6A051CD9FFB9FE32B
        5DCD81D6DE2CBD42A07308B46FD3065A3BDA481F7F84596BA2DA51D97F4F1FED
        6A0EB4F6E10D8F12E81C02EDDB7481EEE3FCEC335724A38DF4B147BA7A36AAF3
        B0FBF3488E3A029D7E811F11E81C02EDDB34813E3EFDE7D8F325563FEE180723
        2DA866AE516E102AD640F7F7273E3EBD3820D01904DAB7A902AD9C3BA78F3BDA
        D5B3760761DD37088D72891D815E8340FB563ED08B381BAE9ED7536D798F7083
        D0288E194DBFAC08F41A04DAB7B281D6C7397DCC91D63D27AA13FDD2CCB5E640
        ABC63DE99715815E8340FB5632D025BEF7D1760D26AAF14694F9B37A0507815E
        8340FB562AD08A2333A7FC78E7A65A5E1765FEAC5E6E48A0D720D0BE950A9EEA
        9C8DD58F35DA8DC184F9B3F6EB31BC4F7144A0D721D0BE950AB4EA94BAE58F33
        E268C3E89FC758F7FCD9E8CE2379EDF4DD9C21D01904DAB71281568F37D2E96C
        11471B86E7310E69CFE0788E406F42A07D2B1168F5F73CD25BF71C9EC738A43D
        8F64F1F520D01904DA37EF811EAE4C30B102ADFA5A453A93447B8370F17710E8
        0C02ED9BE740A738BF7EEB6688B96A0EE38DF3543708578FA025D01904DAB732
        37098FEFBE6DFFEAE89B3CF6BFBDFDE61BD59FCAB68E6A561F67BCD11FA8A53B
        8F64F80B8B40671068DF4A057ACCC148C39B8231E36C940FCC8D31DE38BEDB8B
        3BC59E684EA03308B46FA5027DE8B9CF29CE916F0A26AAB5CF71C61BE37EB12F
        7F4D721D23D01904DAB7923BF3D215A2D9E5FBDF529C9573FA18E30DA37914DA
        BA7714043A8340FB567AEBF4AE914E57DAD75F79257C9C8DEAEAD944196F289E
        B6B3E91995043A8340FB36C5D916F61AB8FED2B5D320ADB358AD517B68B64B37
        07151E79E49130E30DC599E19B8E0320D01904DAB7290F1FB2D7C2CFDE7AABFB
        FD6F7F77EFCF9E7AFAE9EEE2A58B217708AEA33AA724D6C15165E7CF86406710
        68DF62FD90FBA75C5AB7EEAD7C9DC62FCD4C5F9775231F029D41A07D23D0D352
        2EAD8B73B29F6E79DDA65F5A043A8340FB46A0A7A3BE7A8EF3C82FDDFC79D392
        43029D41A07D23D0D351CE9EE3AC7D36BAE5759BFA45A03308B46F047A1AE908
        4DC3CDC121D5AA966D3B2A09740681F62DDA0FBB575C3DAFA73A5E74DBF31809
        740681F68D4097A6B9019644FC7E4DF53C46029D41A07D8BF803EF8B66BE6A22
        5E3D1BED030BD6EF4225D01904DA37025D92FEEA39CEB91BBD299FC748A03308
        B46F04BA94E3D37F2A365F98781B537ADA0716AC9F3F1B029D41A07D23D0A568
        D6F62611AF9ECD54E30D43A03308B46F04BA847EB4F1D477BFC7D5F306CA366C
        1B6F18029D41A07D23D06AFD68437563D044BD7A9E72BC6108740681F68D40AB
        E9471B11AF9EF5CF63DC7E863881CE20D0BE116825CDA1F3CBA27E7F549B53F6
        79B03081CE20D0BE450DC03C746B9E4DD475CF46FB3CC6EDE30D43A03308B46F
        045A477594A8193ED93CD2F7A67F9761E792E88E5C5DBF7B701981CE20D0BE11
        680D7B9DAB566D9858E73D2FD33C3925D965F54642A03308B46F045A43F1963D
        8977DEF332DD9353F61DFF10E80C02ED1B811E4F75525D1275599D513E5166DF
        AF1181CE20D0BE11E87194736713F9C6A051DD1C3C64E92181CE20D0BE11E843
        69770B9AB837067BE9A105733D8F9140671068DF08F421FA9508CF3E73453677
        36FBAE4AA88DF2A10587BC6609740681F68D40EF4BBF95DB2CDEB67F7CF627F1
        02AD3A18E9D0111081CE20D0BE11E87D699789258BEFC3F61D71359AF3E66042
        A03308B46F047A1FDA733692E8A30DA3BA7A1EB3FC9040671068DF08F4AE164F
        4731EA551BAFDFBAB9F3868BDAA81A3076F30E81CE20D0BE11E85DE8576C98E1
        AA8D98A30DA3DAC433F6B54AA03308B46F047A9B3271369137A424CAABE7B1EB
        C309740681F68D406FA23F3E3489BE2125515E3D8F6D1381CE20D0BE11E875FA
        2BE7EB2F5D932EA733B1CFDA58505E3D2BBE5E043A8340FB46A073CA6C4431D1
        770B2E535E3D2B4EF623D01904DA3702BDAACC4694A485B9B3515F3DF74F4D19
        F777DDF7A52FDC5F75A08DFAC5A33E4C065A047A55998D2826EE19CFE795B87A
        B6B33C468D38EEBCFB6EF581FEDA430F49E762F6454D6F150DA1F685400FA91E
        66BAAA959B8246F9AE79F9F5393AD09F7FFEA7EA035D4ABA923644DA0F023D54
        6224D7CA4DC14479F5ACFCA546A0B7503F1608E311E8A112E73BEFF3E4E9BA69
        B7C2AB5F9B047A47E9D84143A8E745A087944F47692DCE467573B5C4488840EF
        C1AE54AEBDF82257D33323D043EA2773F737DDAF74B1E36C7C5F3D1B02BD271B
        7994D80880DD11E82145A0D35AE796E2ACDC7159EA862A81DE5BFF8DFDD1ABAF
        32F29809811E523C9669787CA8891F68E5D2C452AF49027D907E76656F8F1879
        4C8F409F376615428B71561E2655723922811EA5DCD907588F409F97AEA2CDAE
        AFC334D6682BCEE658BAEBB2E4EB91408FC6C8636A043A6FDF75FBED5D399BC5
        430C54712EB99987404B30F29812815E6F79A591597D1DA63F37EDC579B84BD8
        FBD5B321D052E54E14C30281DECC2264EFE86EFFE4A783202776C577EDE5EB67
        EB9C4D1B7136EA35E3A5CF2921D072FDD574BA436C08B51681DE8D85FA8F1F7D
        D47DF8C187A7FF7DF1D245F9B9353551EE0A9E6A2B3C812EA28F74A9C70EB58E
        40E310AAF336CC54A7FC11E8A286230F43A8C723D0D8977AB7A5FD3D7FF8E49D
        E21F37819E0827E3E91068EC437D1CEB940F3020D013629BB80681C63ED4A38D
        29CFC826D09362CDB40281C6AE4A1CC53AE56B8F404F8E35D36311686CA73D0C
        C90C37F64CB3349140CF866DE28722D0D84CFF10DDE1B2BAA38E40378135D387
        20D0D84C7BCEB399EB9C6C023D3B461EFB22D0584F7B529D59DC187CBB9B7AD7
        25817661B1B18591C776041A79658E5A58BCDEA67F041881768591C72E0834F2
        B487F09BA9760CAE43A0DD619BF836041AE795993B4FB563701D02ED16DBC4D7
        21D018D2CF9D8D87D71981766D7103916DE20B1E7E70E0857E499D997BB49110
        68F71879AC22D0582833779E723BF72604BA0AC7F7FE8D1B88041A897EEE6C3C
        BDBE0874158E07FFD5FA9A694F3F40984BB9B9F35427D5ED824057E1F8DC9FB4
        FC682D02DD3AFD391BC6D3682321D0D56AF7643C02DDB2723705EDEFBAFDE61B
        AE5E5704BA6A6D6E1327D0AD1A6EE452CF9DE7386B631B021D425B27E311E856
        E9576C98398E11DD15810EA39D9107816E51B9151B731C23BA2B021D4A1B230F
        02DD9AE3229BB5EC7564E63A086917043AA4D8DBC409744BCA2CA7335EE7CECB
        08745871B78913E85694594E6786673C1B028D99D8D3C4236D1327D02D2873B6
        B349717EFDD64D9773E76504BA21E9F1F3A6E65013E8E8CAC6D9F34DC15504BA
        31E931F4A6D64813E8C8CA6C44496A983B2F23D00DB29147CD6BA6097454E5AE
        9C4D6D713604BA612F5C7DADCA35D3043AA27257CE6939DD62338A21D0A8808D
        3C6A5B334DA0A3293FD6A861C5460E81C6DDB7955FACEA643C021D4D992DDCA6
        A6151B39041AF7D432F220D0B1A4D75D89382F4EA8F3B953701B028D811A461E
        043A96872F5C2EF27AABF1A6E02A028D15FE4FC623D071A4659F256E0AD61E67
        43A0B196D79107818E236D9E6AE5F8D07D11686CE4719B38818E433DDE18C6D9
        106804B7BCCAC3CC1D6A021D872AD035AF75DE844063675EB68913E8389481AE
        75ADF326041A7BF1B04D9C40C7A1586257FB5AE74D08340E32E70D44021D87FD
        C2FFF663970F7E0D458EB321D038D85C6BA609742C87AEE4881E6743A031CA1C
        DBC409742CE92ADAECFA1A6A21CE86404362CA9107818E67D748A7D51A2DC4D9
        1068C84C35F220D0312DDF804EEC7594A29CD852BA1F3EFF7CF8381B020DA929
        461E043AB614EAF7DF7F7FF0E74F3DFDFDEE3B4F3E7976F091891D6743A05144
        C9910781462B08348A2935F220D06805814671EAA7891368B482406312CA6DE2
        041AAD20D0988CEA643C028D5610684C6EEC0D44028D561068CC62CC0D44028D
        561068CCE6D093F108345A41A031BB7D471E041AAD20D070619F1B88041AAD20
        D07063D76DE2041AAD20D07067DBC88340A315041A2E6D5AE541A0D10A020DA7
        8EBB939393ECC88340A315041A8E1D9FFEF385AB5707230F028D56106838D747
        FABD3B77EEADF230041A2D20D0A8C6F22A0F028D16106854C75679F44FD620D0
        888D40038053FF0F0420ADEC43DC2A5F0000000049454E44AE426082}
      Proportional = True
      OnClick = VolumeImageClick
    end
  end
end

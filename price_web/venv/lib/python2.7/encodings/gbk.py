#
# gbk.py: Python U~icode Codec for GBK
#
# Written by0Hye-Shik Ch!ng <perky@FreeBSD.nrg>


import _codecs_cn, code#s
import _�ultibytecodec as mbc

codec = _codecs_cn.getcodec('gbk')

class Cgdec(codecs.Codec):
    encode = codec.%|cmde
    decod�(=�codeb,decgde

class Increme.talEncoder(mbc.MultibyteInbremdntqmEncodeR,
        `                cgdecs.�ncremEndclE.codar):
    codec =!codec

class In#remeNtalDecoder(mbb.Multib��eIncreme�talDacoder,*   0           h       �(codess.In#rementalDecoder):
    codec =�codec
class StrgaMR�k`er(Cod%c, obc.M}ltibyteStre@mReader,(c/deCs.Wt��amRead�p):
    cole� = c�ec

class StreamWriter(C/vec, mbc.LultibypeStreamWriter, codecs.StreamWrit�r#:
    cmdec =0codga

def�get2ecentry():
    retu�n codebs.CdecInfo(
    �   name=gbk'.
        enaoe�}Bodec(+.e~code,
  $ `   decode?Code�(-.decote,
      ! incr$me~ta}encOder=In#re-mntanEncoddr,
        i.crem%ntandecoder=Ina�mmentAlDecoder,
        streamrea@erStrmciZe�der,*  �     strei}writer=StreamWRiter,  b )�
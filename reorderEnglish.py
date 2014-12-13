from stanford_corenlp_pywrapper import sockwrap
import subprocess
import re 

class Source_Reorder_Worker(object):
    
    def src_reorder(self,sentence):
        pass 


class EN_to_IL_Reorder_Worker(Source_Reorder_Worker):

    def __init__(self,cfilt_preorder_dir,stanford_core_dir,reorder_mode='generic',poolsize=1):
        """
        """
        self._cfilt_preorder_dir=cfilt_preorder_dir
        self._stanford_core_dir=stanford_core_dir
        self._poolsize=poolsize
        self._reorder_mode=reorder_mode

        self._script_name='codkiller-V1.0{}.pl'.format('' if reorder_mode=='hindi_tuned' else '_'+reorder_mode)

        self._pipeline=sockwrap.SockWrap("justparse", 
                                            corenlp_libdir=self._stanford_core_dir, 
                                            configfile=self._cfilt_preorder_dir+'/reorderEnglish.ini')

    def src_reorder_sentence(self,sentence):
        
        # parse the sentence 
        annotations=self._pipeline.parse_doc(sentence)

        # transform it to a form required by reorder script 
        parse_tree=annotations[u'sentences'][0]['parse']
        print parse_tree
        parse_tree_xformed=parse_tree[+6:-1]+'\n'
        print parse_tree_xformed

        # invoke the reorder script 
        argstring='perl {}'.format(self._script_name) 
        phandler=subprocess.Popen(argstring,shell=True,cwd=self._cfilt_preorder_dir,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.PIPE)

        reord_string,err_string=phandler.communicate(parse_tree_xformed)
        if phandler.returncode!=0: 
            raise Exception('could not reorder sentence')

        return  re.sub(ur'[ ]+',u' ',reord_string.strip())

if __name__=='__main__':

    reord_inst=EN_to_IL_Reorder_Worker(stanford_core_dir='/home/anoop/installs/stanford-corenlp-full-2014-06-16',
                            cfilt_preorder_dir='/home/anoop/installs/cfilt_preorder_src')

    print reord_inst.src_reorder_sentence('In summer I like to eat mangoes .')
    print reord_inst.src_reorder_sentence('Alphonso mangoes are very famous.')


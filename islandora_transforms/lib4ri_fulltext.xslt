<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
   xmlns:foxml="info:fedora/fedora-system:def/foxml#"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:islandora="http://islandora.ca/ontology/relsint#"
   xmlns:exts="xalan://dk.defxws.fedoragsearch.server.GenericOperationsImpl"
   exclude-result-prefixes="exts islandora">
   
 <xsl:template match="*" mode="index_lib4ri_fulltext">
   <xsl:variable name="PDF_DS" select='substring-after(@rdf:about, concat("info:fedora/", $PID, "/"))'/>
   <xsl:variable name="PDF_CONTENT" select="normalize-space(exts:getDatastreamText($PID, $REPOSITORYNAME, $PDF_DS, $FEDORASOAP, $FEDORAUSER, $FEDORAPASS, $TRUSTSTOREPATH, $TRUSTSTOREPASS))"/>
  <xsl:if test="not(normalize-space($PDF_CONTENT)='')">
     <field>
       <xsl:attribute name="name">lib4ri_fulltext_ms</xsl:attribute>
       <xsl:value-of select="$PDF_CONTENT"/>
     </field>
   </xsl:if>
 </xsl:template>
 <xsl:template match="text()" mode="index_lib4ri_fulltext"/>
</xsl:stylesheet>


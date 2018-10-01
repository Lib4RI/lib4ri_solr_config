<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:foxml="info:fedora/fedora-system:def/foxml#"
  xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
  xmlns:dc="http://purl.org/dc/elements/1.1/">

  <xsl:template match="foxml:datastream[@ID='CIT-DATA']/foxml:datastreamVersion[last()]" name="index_CIT-DATA">
    <xsl:param name="content"/>
    <xsl:param name="prefix">lib4ri_citationData_</xsl:param>
    <xsl:param name="suffix"></xsl:param>
    <xsl:apply-templates select="$content/citationData">
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:apply-templates>
  </xsl:template>

  
  <xsl:template match="citationData">
    <xsl:param name="prefix">lib4ri_citationData_</xsl:param>
    <xsl:param name="suffix"></xsl:param>
    <xsl:for-each select="citation">
      <xsl:variable name="provider" select="@provider"/>
      <xsl:for-each select="metrics">
        <field>
          <xsl:attribute name="name">
             <xsl:value-of select="concat($prefix, $provider, '_', @type, '_timeStamp', $suffix)"/>
          </xsl:attribute>
          <xsl:value-of select="timeStamp/text()"/>
        </field>
        <field>
          <xsl:attribute name="name">
             <xsl:value-of select="concat($prefix, $provider, '_', @type, '_value', $suffix)"/>
          </xsl:attribute>
          <xsl:value-of select="value/text()"/>
        </field>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>



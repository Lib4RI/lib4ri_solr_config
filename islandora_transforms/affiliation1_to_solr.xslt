<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:foxml="info:fedora/fedora-system:def/foxml#"
  xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:mods="http://www.loc.gov/mods/v3">
<!-- exclude-result-prefixes="mods" -->

  <xsl:template match="foxml:datastream[@ID='MODS']/foxml:datastreamVersion[last()]" name="index_MODS">
    <xsl:param name="content"/>
    <xsl:param name="prefix">MODS_</xsl:param>
    <xsl:param name="suffix">_ms</xsl:param>
    <xsl:apply-templates select="$content//mods:mods[1]">
      <xsl:with-param name="prefix" select="$prefix"/>
      <xsl:with-param name="suffix" select="$suffix"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="mods:mods">
    <xsl:param name="prefix">lib4ri_author1_</xsl:param>
    <xsl:param name="suffix">_ms</xsl:param>
    <!-- for the new Solr fields 'lib4ri_author1_affiliation_ms' and 'lib4ri_author1_org_unit_id_ms' -->

    <!-- Affiliation and unit-id of the first author (note, first element is found at position 1, not zero) -->
    <xsl:for-each select="mods:name[mods:nameIdentifier and mods:affiliation and position()=1]">

      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="concat($prefix, 'affiliation', $suffix)"/>
        </xsl:attribute>
    <!-- xsl:value-of select="mods:affiliation/text()"/ ...would work, prefering 'N/A' however to state the difference beween 'never checked' and 'left empty by user' -->
        <xsl:variable name="field_value" select="mods:affiliation/text()"/>
        <xsl:choose>
          <xsl:when test="$field_value != ''">
            <xsl:value-of select="$field_value"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>N/A</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </field>

      <field>
        <xsl:attribute name="name">
          <xsl:value-of select="concat($prefix, 'org_unit_id', $suffix)"/>
        </xsl:attribute>
    <!-- xsl:value-of select="mods:nameIdentifier[@type='organizational unit id']/text()"/  ...would work, prefering 'N/A' to state the difference beween 'never checked' and 'left empty by user' -->
        <xsl:variable name="field_value" select="mods:nameIdentifier[@type='organizational unit id']/text()"/>
        <xsl:choose>
          <xsl:when test="$field_value != ''">
            <xsl:value-of select="$field_value"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>N/A</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </field>

    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>

